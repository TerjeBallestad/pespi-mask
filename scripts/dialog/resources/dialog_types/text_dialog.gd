class_name TextDialog extends Dialog

# Since ChoiceDialog extends TextDialog, we don't want the Next button there
var show_button := true

@export
var speaker: DialogSpeaker

@export
var text: String

func on_display(box: DialogBox) -> void:
	var spkr := speaker
	
	if not speaker:
		spkr = DialogManager.last_speaker
		
	box.portrait.texture = speaker.portrait
		
	DialogManager.last_speaker = spkr
		
	box.speaker_label.text = spkr.name
	box.text_label.crawl(text)
	
	if not show_button:
		return
		
	box.options_buttons[0].visible = true
	box.options_buttons[0].text = "Next"
	box.choice_made.connect(_on_click_next)

func on_hide(box: DialogBox) -> void:
	if not show_button:
		return
	
	box.options_buttons[0].visible = false
	box.choice_made.disconnect(_on_click_next)

func _on_click_next(_box: DialogBox, _choice_index: int):
	DialogManager.next_dialog()
