class_name DialogBox extends Control

@onready
var _original_y := position.y

@export
var speaker_label: RichTextLabel

@export 
var text_label: RichTextLabel

@export
var slide_animation_duration := 1.0

func _ready():
	%DialogManager.entering_dialog_playback.connect(_on_entering_dialog_playback)
	%DialogManager.entering_dialog.connect(_on_entering_dialog)
	%DialogManager.exiting_dialog_playback.connect(_on_exiting_dialog_playback)
	position.y = _original_y + size.y

func _process(delta: float):
	if %DialogManager.playing:
		%DialogManager.current_dialog.process(delta, %DialogManager)
		
func _on_entering_dialog_playback():
	slide_in()
		
func _on_entering_dialog(dialog: Dialog):
	dialog.on_display(self, %DialogManager)
		
func _on_exiting_dialog_playback():
	slide_out()

func slide_in():
	create_tween().tween_property(self, "position:y", _original_y, slide_animation_duration)
	
func slide_out():
	create_tween().tween_property(self, "position:y", _original_y + size.y, slide_animation_duration)
