class_name ClickableObject extends Area2D

signal object_interacted_with(name:String)

func get_clickable_manager():
	return get_tree().current_scene.get_node_or_null("ClickManager")

func leftMouseClick():
	# Block clicks during dialog
	var dialog_mgr = get_tree().current_scene.get_node_or_null("GameUI/DialogManager")
	if dialog_mgr and dialog_mgr.playing:
		return

	get_clickable_manager().selectedElement = self
	object_interacted_with.emit(name)

func _on_mouse_entered() -> void:
	var manager = get_clickable_manager()
	if manager:
		manager.setHoveredNode(self)


func _on_mouse_exited() -> void:
	var manager = get_clickable_manager()
	if manager:
		manager.unsetHoveredNode(self)
