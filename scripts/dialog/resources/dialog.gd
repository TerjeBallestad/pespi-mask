@abstract
class_name Dialog extends Resource

@export_group("Conditions")
@export
var enabled := true

@export
var condition: DialogCondition

func on_display(_box: DialogBox, _manager: DialogManager) -> void:
	pass

func process(_delta: float, _manager: DialogManager) -> void:
	pass
