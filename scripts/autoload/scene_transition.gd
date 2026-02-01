extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect
var transitioning: bool = false


func _ready() -> void:
	# Start fully transparent
	color_rect.modulate.a = 0.0
	# Don't block input when not transitioning
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE


func change_scene(scene_path: String, fade_duration: float = 0.3) -> void:
	# Prevent double-transitions
	if transitioning:
		return

	transitioning = true
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

	# Block input during transition
	color_rect.mouse_filter = Control.MOUSE_FILTER_STOP

	# Fade to black
	var fade_out_tween := create_tween()
	fade_out_tween.tween_property(color_rect, "modulate:a", 1.0, fade_duration)
	await fade_out_tween.finished

	# Change scene
	get_tree().change_scene_to_file(scene_path)

	# Wait for new scene to be ready
	await get_tree().process_frame

	# Fade back in
	var fade_in_tween := create_tween()
	fade_in_tween.tween_property(color_rect, "modulate:a", 0.0, fade_duration)
	await fade_in_tween.finished

	# Re-enable input
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE

	transitioning = false
