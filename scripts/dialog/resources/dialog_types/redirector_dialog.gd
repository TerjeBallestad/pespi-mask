class_name RedirectorDialog extends Dialog

@export
var sequence: DialogSequence

func on_display(_box: DialogBox, manager: DialogManager) -> void:
	manager.redirect(sequence)
	manager.next_dialog()
