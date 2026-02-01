class_name ExitPoint extends ClickableObject

@export var target_scene: String = ""
@export_node_path("Marker2D") var walk_target_path: NodePath = "WalkTarget"

var walk_target: Marker2D

func _ready() -> void:
	super._ready()
	object_interacted_with.connect(_on_interacted)


# func _on_mouse_entered() -> void:
# 	_is_hovered = true
# 	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


# func _on_mouse_exited() -> void:
# 	_is_hovered = false
# 	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


# func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
# 	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
# 		_try_exit()


# func _try_exit() -> void:
# 	# Block exit during dialog
# 	if has_node("%DialogManager") and %DialogManager.playing:
# 		return

# 	if target_scene.is_empty():
# 		push_warning("ExitPoint has no target_scene set")
# 		return

# 	# Extract room ID from scene path (e.g., "res://scenes/basement.tscn" -> "basement")
# 	var room_id = target_scene.get_file().get_basename()

# 	if not GameState.is_room_unlocked(room_id):
# 		# Room is locked - could emit signal or show message later
# 		return

# 	exit_triggered.emit()
# 	_initiate_exit()


# func _initiate_exit() -> void:
# 	# Get player and tell it to walk to exit
# 	var player = get_tree().get_first_node_in_group("player")
# 	if player and player.has_method("walk_to_exit"):
# 		var target_pos = walk_target.global_position if walk_target else global_position
# 		player.walk_to_exit(target_pos, _on_player_reached_exit)
# 	else:
# 		# No player or no walk_to_exit method - transition immediately
# 		_on_player_reached_exit()


# func _on_player_reached_exit() -> void:
# 	if target_scene:
# 		SceneTransition.change_scene(target_scene)
func _on_interacted(_name: String) -> void:
	SceneTransition.change_scene(target_scene)
