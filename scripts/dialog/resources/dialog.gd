@abstract
class_name Dialog extends Resource

@export_group("Conditions")
## Whether this dialog entry is enabled. 
## Disabled entries will never be executed, but their conditions are still used by other entries with group_with_above set
@export
var enabled := true

## The condition that must be met for this dialog entry to execute
@export
var condition: DialogCondition

## If enabled, the condition of the node directly above this one must also be true (specifically when it is evaluated)
## This is independent of whether the node above is enabled or not
## You may combine this with a condition
@export
var group_with_above := true

func on_display(_box: DialogBox, _manager: DialogManager) -> void:
	pass

func on_hide(_box: DialogBox, _manager: DialogManager) -> void:
	pass

func process(_delta: float, _manager: DialogManager) -> void:
	pass
