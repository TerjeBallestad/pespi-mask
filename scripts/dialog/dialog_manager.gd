class_name DialogManager extends Node

signal entering_dialog_playback
signal entering_dialog_sequence(sequence: DialogSequence)
signal entering_dialog(dialog: Dialog)

signal redirecting(old: DialogSequence, new: DialogSequence)

signal exiting_dialog_playback
signal exiting_dialog_sequence(sequence: DialogSequence)
signal exiting_dialog(dialog: Dialog)

var _current_sequence: DialogSequence
var _playing := false
var _sequence_index := -1

# TODO: Should not be exported. Need controllable functions for this and a signal upon assignment
@export
var variables: Dictionary[String, Variant] = {}

var playing: bool:
	get: 
		return _playing

# TODO: Exported for test purposes. Should be not be exported nor have a setter
@export
var current_sequence: DialogSequence:
	get:
		return _current_sequence
	set(value):
		_current_sequence = value

# TODO: For testing
func _ready() -> void:
	start_dialog(current_sequence)

var current_dialog: Dialog:
	get:
		if current_sequence == null or _sequence_index >= len(current_sequence.dialogs):
			return null
		
		return current_sequence.dialogs[_sequence_index]

func start_dialog(seq: DialogSequence) -> Error:
	if playing:
		# Use redirect() to change what dialog is being played
		return ERR_ALREADY_IN_USE
	
	_playing = true
	
	# This is done to make sure current_sequence is set when entering_dialog is emitted.
	# Want entering_dialog to run before entering_dialog_sequence
	# This assignment is otherwise useless since redirect() sets it too
	_current_sequence = seq
	
	entering_dialog_playback.emit()
	redirect(seq)
	next_dialog()
	
	return OK

func next_dialog() -> Error:
	if not playing:
		return ERR_UNCONFIGURED
	
	if current_dialog:
		exiting_dialog.emit(current_dialog)
	
	var loop_count := 0
	while true:
		loop_count += 1
		if loop_count > 100:
			print("LOOP BROKEN") # HACK: This shouldn't need to be here but I am paranoid
			break
			
		_sequence_index += 1
		
		# End of dialog. Stopping
		if not current_dialog:
			stop_dialog()
			return OK
			
		# Disabled dialog. Automatic not OK
		if not current_dialog.enabled:
			continue
			
		# No condition. OK
		if not current_dialog.condition:
			break
			
		# Condition that is met. OK
		if current_dialog.condition.is_condition_met(self):
			break
	
		# Otherwise condition isn't met. Not OK

		
	entering_dialog.emit(current_dialog)
		
	return OK

func stop_dialog():
	if not playing:
		return
	
	if current_dialog != null:
		exiting_dialog.emit(current_dialog)
	
	exiting_dialog_sequence.emit(current_sequence)
	exiting_dialog_playback.emit()
	
	current_sequence = null
	_sequence_index = -1
	_playing = false
	
func redirect(seq: DialogSequence):
	if current_sequence != null:
		exiting_dialog_sequence.emit(current_sequence)
		redirecting.emit(current_sequence, seq)
		
	_current_sequence = seq
	_sequence_index = -1
	entering_dialog_sequence.emit(seq)
