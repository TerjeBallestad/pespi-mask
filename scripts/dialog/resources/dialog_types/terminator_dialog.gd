## Stops the current dialog sequence

class_name TerminatorDialog extends Dialog

func on_display(_box: DialogBox, manager: DialogManager) -> void:
	manager.stop_dialog()
