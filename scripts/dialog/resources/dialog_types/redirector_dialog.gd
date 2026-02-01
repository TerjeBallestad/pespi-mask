class_name RedirectorDialog extends Dialog

@export
var sequence: DialogSequence

func on_display(_box: DialogBox) -> void:
	DialogManager.redirect(sequence)
	DialogManager.next_dialog()
