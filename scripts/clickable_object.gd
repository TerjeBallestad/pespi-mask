extends Area2D



func leftMouseClick():
	get_tree().root.get_child(0).selectedElement = self
	print('%s object is on the top, and clicked!' % name)

func _on_BoxObject_input_event(_viewport, event, _shape_idx):
	pass

func _on_BoxObject_mouse_exited():
	get_tree().get_root().unsetHoveredNode(self)
	print("object is moved off")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_entered() -> void:
	get_tree().root.get_child(0).setHoveredNode(self)
	print("object is moved on")


func _on_mouse_exited() -> void:
	get_tree().root.get_child(0).unsetHoveredNode(self)
	print("object is moved off")
