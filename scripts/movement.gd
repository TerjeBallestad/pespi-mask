extends CharacterBody2D

signal movement_finished
signal movement_canceled

var target: Vector2
@export var speed = 400
@export var min_distance_to_target:float = 10

var move_callback: Callable
var is_walking_to_exit: bool = false


func _input(event: InputEvent) -> void:
	# Block input during dialog
	var dialog_mgr = get_tree().current_scene.get_node_or_null("GameUI/DialogManager")
	if dialog_mgr and dialog_mgr.playing:
		return

	# Block during scene transitions
	if SceneTransition.transitioning:
		return

	if event is InputEventMouseButton && event.pressed:
		# Don't process movement if clicking on a clickable object (NPC, item, etc.)
		var click_mgr = get_tree().current_scene.get_node_or_null("ClickManager")
		if click_mgr and click_mgr.hoveredElement != null:
			return

		# Cancel walk-to-exit if player clicks elsewhere
		if is_walking_to_exit:
			is_walking_to_exit = false
			move_callback = Callable()
			movement_canceled.emit()
		set_target_position()


func set_target_position():
	var ground: Polygon2D = get_tree().get_first_node_in_group("Ground")
	if ground == null:
		# No ground polygon defined - allow free movement
		target = get_global_mouse_position()
		return
	var poly := ground.polygon
	if Geometry2D.is_point_in_polygon(ground.to_local(get_global_mouse_position()),poly):
		target = get_global_mouse_position()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	var direction = position.direction_to(target)
	velocity = direction * speed
	if position.distance_to(target) > min_distance_to_target:
		move_and_slide()
	else:
		# Reached target - check for walk-to-exit callback
		if is_walking_to_exit and move_callback.is_valid():
			is_walking_to_exit = false
			var callback := move_callback
			move_callback = Callable()
			callback.call()
			movement_finished.emit()


func walk_to_exit(exit_pos: Vector2, callback: Callable) -> void:
	is_walking_to_exit = true
	target = exit_pos
	move_callback = callback
