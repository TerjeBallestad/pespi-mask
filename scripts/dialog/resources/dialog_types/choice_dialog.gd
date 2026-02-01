class_name ChoiceDialog extends TextDialog

@export
var choices: Array[DialogOption]

func _init():
	show_button = false

func on_display(box: DialogBox) -> void:
	super.on_display(box)
	
	for i in min(len(choices), len(box.options_buttons)):
		var button := box.options_buttons[i]
		
		button.text = choices[i].text
		button.visible = true
		
	box.choice_made.connect(_on_choice_made)

func on_hide(box: DialogBox) -> void:
	for i in len(box.options_buttons):
		box.options_buttons[i].visible = false
		
	box.choice_made.disconnect(_on_choice_made)

func _on_choice_made(_box: DialogBox, choice_index: int):
	var seq := DialogSequence.new()
	seq.dialogs.append(choices[choice_index].dialog)
	DialogManager.redirect(seq)
	DialogManager.next_dialog()
