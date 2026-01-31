extends CharacterBody2D

var target: Vector2
@export var speed = 400
@export var min_distance_to_target:float = 10
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton && event.pressed:
		set_target_position() 
		
func set_target_position():
	var ground: Polygon2D = get_tree().get_first_node_in_group("Ground")
	var poly := ground.polygon
	print(poly)
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
