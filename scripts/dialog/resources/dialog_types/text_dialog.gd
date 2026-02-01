class_name TextDialog extends Dialog

# Since ChoiceDialog extends TextDialog, we don't want the Next button there
var show_button := true

@export
var speaker: DialogSpeaker

@export
var text: String

func on_display(box: DialogBox, manager: DialogManager) -> void:
	var spkr := speaker

	if not speaker:
		spkr = manager.last_speaker

	manager.last_speaker = spkr

	box.speaker_label.text = spkr.name

	# Set portrait if available
	if box.portrait_rect and spkr.portrait:
		box.portrait_rect.texture = spkr.portrait
		box.portrait_rect.visible = true
	elif box.portrait_rect:
		box.portrait_rect.visible = false

	box.text_label.crawl(text)

	if not show_button:
		return

	box.options_buttons[0].visible = true
	box.options_buttons[0].text = "Next"
	box.choice_made.connect(_on_click_next)

func on_hide(box: DialogBox, _manager: DialogManager) -> void:
	if not show_button:
		return

	box.options_buttons[0].visible = false
	box.choice_made.disconnect(_on_click_next)

func _on_click_next(_box: DialogBox, manager: DialogManager, _choice_index: int):
	manager.next_dialog()
