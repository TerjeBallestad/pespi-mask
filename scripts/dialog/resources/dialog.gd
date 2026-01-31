@abstract
class_name Dialog extends Resource

@export
var condition: DialogCondition

func on_display(box: DialogBox, manager: DialogManager) -> void:
	pass

func process(delta: float, manager: DialogManager) -> void:
	pass
