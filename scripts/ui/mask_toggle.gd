extends TextureButton

## Called when scene is ready
func _ready() -> void:
	# Ensure toggle mode is enabled
	toggle_mode = true

	# Hide until mask is acquired
	visible = GameState.get_flag("has_mask")

	# Connect to toggle
	toggled.connect(_on_toggled)

	# Listen for mask acquisition
	if not GameState.get_flag("has_mask"):
		GameState.flag_changed.connect(_on_flag_changed)

	_update_visual()

func _on_flag_changed(flag_name: String, _value: Variant) -> void:
	if flag_name == "has_mask":
		visible = true
		GameState.flag_changed.disconnect(_on_flag_changed)

func _on_toggled(is_pressed: bool) -> void:
	# Block toggle during dialog
	var dialog_mgr = get_tree().current_scene.get_node_or_null("GameUI/DialogManager")
	if dialog_mgr and dialog_mgr.playing:
		button_pressed = not is_pressed  # Revert
		return

	if is_pressed:
		PepsiManager.put_on_mask()
	else:
		PepsiManager.remove_mask()
	_update_visual()

func _update_visual() -> void:
	# Visual feedback for mask state
	if PepsiManager.is_wearing_pepsi_mask():
		modulate = Color(0.5, 1.0, 0.5)  # Green tint when wearing
	else:
		modulate = Color.WHITE
