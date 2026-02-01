extends CharacterBody2D

signal movement_finished
signal movement_canceled

var target: Vector2
@export var speed = 400
@export var min_distance_to_target:float = 10

## Callback to execute when walk-to-exit completes
var move_callback: Callable
## Whether currently walking to an exit point
var is_walking_to_exit: bool = false

func _input(event: InputEvent) -> void:
	if DialogManager.playing:
		return
	
	if event is InputEventMouseButton && event.pressed:
		# Cancel walk-to-exit if player clicks elsewhere
		if is_walking_to_exit:
			is_walking_to_exit = false
			move_callback = Callable()
			
		movement_canceled.emit()
		set_target_position_from_mouse()

func set_target_position_from_mouse():
	var ground: Polygon2D = get_tree().get_first_node_in_group("Ground")
	var poly := ground.polygon
	if Geometry2D.is_point_in_polygon(ground.to_local(get_global_mouse_position()),poly):
		target = get_global_mouse_position()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target = position
	
	ClickableObjectControl.interaction_queued.connect(func(obj: ClickableObject):
		if obj is ExitPoint:
			target = (obj as ExitPoint).walk_target.global_position
			return
		target = obj.global_position + Vector2(0, 15)
	)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	var direction = position.direction_to(target)
	velocity = direction * speed
	if position.distance_to(target) > min_distance_to_target:
		$AnimatedSprite2D.flip_h = velocity.x < 0
		
		$AnimatedSprite2D.play("walk_mask" if GameState.is_wearing_pepsi_mask() else "walk")
			
		move_and_slide()
	else:
		# Reached target - check for walk-to-exit callback
		if is_walking_to_exit and move_callback.is_valid():
			is_walking_to_exit = false
			var callback := move_callback
			move_callback = Callable()
			callback.call()
			
		movement_finished.emit()	
		ClickableObjectControl.dequeue()

		$AnimatedSprite2D.play("idle_mask" if GameState.is_wearing_pepsi_mask() else "idle")

func walk_to_exit(exit_pos: Vector2, callback: Callable) -> void:
	is_walking_to_exit = true
	target = exit_pos
	move_callback = callback
