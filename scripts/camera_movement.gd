extends Camera2D

#@export var speed := 0.1
#@export var target: Node2D
@export var background: Sprite2D

func _ready() -> void:
	var rect := background.get_rect()
	
	limit_left = rect.position.x * background.scale.x + background.position.x 
	limit_top = rect.position.y * background.scale.y + background.position.y 
	limit_right = rect.end.x * background.scale.x + background.position.x 
	limit_bottom = rect.end.y * background.scale.y + background.position.y
	
