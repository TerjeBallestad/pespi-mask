class_name ClickableObject extends Area2D

signal object_interacted_with(name:String)

func _ready():
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func get_clickable_manager():
	return get_tree().root.get_child(0).find_child("ClickManager",false)

func leftMouseClick():
	get_clickable_manager().selectedElement = self
	object_interacted_with.emit(name)

func _on_mouse_entered() -> void:
	get_clickable_manager().setHoveredNode(self)
	


func _on_mouse_exited() -> void:
	get_clickable_manager().unsetHoveredNode(self)
	
