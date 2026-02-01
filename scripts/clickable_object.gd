class_name ClickableObject extends Area2D

signal object_interacted_with(name:String)

func _ready():
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func interact():
	object_interacted_with.emit(name)

func leftMouseClick():
	if not DialogManager.playing:
		ClickableObjectControl.queue(self)

func _on_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	ClickableObjectControl.setHoveredNode(self)

func _on_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	ClickableObjectControl.unsetHoveredNode(self)
	
