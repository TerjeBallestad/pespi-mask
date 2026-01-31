extends Area2D

func leftMouseClick():
	get_tree().get_root().selectedElement = self
	print('this object is on the top, and clicked!')

func _on_BoxObject_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseMotion:
		get_tree().get_root().setHoveredNode(self)

func _on_BoxObject_mouse_exited():
	get_tree().get_root().unsetHoveredNode(self)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
