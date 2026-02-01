extends ClickableObject

## Dialog shown when examining mask
@export
var examine_dialog: DialogSequence

## Dialog shown when taking mask
@export
var take_dialog: DialogSequence

var _examined := false

func _ready() -> void:
	object_interacted_with.connect(_on_interacted)

	# Hide if mask already taken
	if GameState.get_flag("has_mask"):
		queue_free()

func _on_interacted(_name: String) -> void:
	if not _examined:
		# First click: examine
		_examined = true
		if examine_dialog:
			%DialogManager.start_dialog(examine_dialog)
		else:
			_show_examine_text()
	else:
		# Second click: take
		_take_mask()

func _show_examine_text() -> void:
	# Fallback if no dialog resource assigned
	# Create simple dialog sequence
	var seq = DialogSequence.new()
	var dialog = TextDialog.new()
	var speaker = DialogSpeaker.new()
	speaker.name = "???"
	dialog.speaker = speaker
	dialog.text = "An ancient mask with the Pepsi logo. It looks... real. Unlike everything else here."
	seq.dialogs.append(dialog)

	var take_dialog_entry = TextDialog.new()
	take_dialog_entry.speaker = speaker
	take_dialog_entry.text = "Click again to take it."
	seq.dialogs.append(take_dialog_entry)

	%DialogManager.start_dialog(seq)

func _take_mask() -> void:
	GameState.set_flag("has_mask", true)

	# Optional: Show taking dialog
	var seq = DialogSequence.new()
	var dialog = TextDialog.new()
	var speaker = DialogSpeaker.new()
	speaker.name = "You"
	dialog.speaker = speaker
	dialog.text = "You take the Pepsi Mask. Something about it feels... authentic."
	seq.dialogs.append(dialog)
	%DialogManager.start_dialog(seq)

	# Remove mask from scene after dialog
	%DialogManager.exiting_dialog_playback.connect(_on_dialog_finished, CONNECT_ONE_SHOT)

func _on_dialog_finished() -> void:
	queue_free()
