extends Control

@export
var speaker_label: RichTextLabel

@export 
var text_label: RichTextLabel

func _ready():
	%DialogManager.entering_dialog.connect(_on_entering_dialog)
	%DialogManager.exiting_dialog_playback.connect(_on_exiting_dialog_playback)
	
func _on_entering_dialog(dialog: Dialog):
	if dialog is TextDialog:
		speaker_label.text = dialog.speaker.name
		text_label.text = dialog.text
		
func _on_exiting_dialog_playback():
	speaker_label.text = ""
	text_label.text = "<Dialog closed>"
		
func _process(_delta: float):
	if Input.is_action_just_pressed("ui_accept"):
		%DialogManager.next_dialog()
