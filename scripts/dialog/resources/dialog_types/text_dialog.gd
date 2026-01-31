class_name TextDialog extends Dialog

@export
var speaker: DialogSpeaker

@export
var text: String

func on_display(box: DialogBox, manager: DialogManager) -> void:
	box.speaker_label.text = speaker.name
	box.text_label.text = text

func process(_delta: float, manager: DialogManager):
	if Input.is_action_just_pressed("ui_accept"):
		manager.next_dialog()
