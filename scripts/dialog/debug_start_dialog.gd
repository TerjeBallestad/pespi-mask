extends Node

@export
var dialog: DialogSequence

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogManager.start_dialog(dialog)
