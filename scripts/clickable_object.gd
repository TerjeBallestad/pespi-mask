class_name ClickableObject extends Area2D

signal object_interacted_with(name:String)

func get_clickable_manager():
	return get_tree().root.get_child(0).find_child("ClickManager",false)


func leftMouseClick():
	get_clickable_manager().selectedElement = self
	object_interacted_with.emit(name)
	print('%s object is on the top, and clicked!' % name)

func _on_BoxObject_input_event(_viewport, event, _shape_idx):
	pass

func _on_BoxObject_mouse_exited():
	get_clickable_manager().unsetHoveredNode(self)
	print("object is moved off")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_entered() -> void:
	get_clickable_manager().setHoveredNode(self)
	print("object is moved on")


func _on_mouse_exited() -> void:
	get_clickable_manager().unsetHoveredNode(self)
	print("object is moved off")
