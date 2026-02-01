class_name MaskToggle extends TextureButton

## Called when scene is ready
func _ready() -> void:
	# Ensure toggle mode is enabled
	toggle_mode = true

	# Hide until mask is acquired
	visible = GameState.get_flag("has_mask")

	# Connect to toggle
	toggled.connect(_on_toggled)

	# Listen for mask acquisition
	GameState.obtaining_mask.connect(_on_obtain_mask)
	
	# Listen for dialog
	DialogManager.entering_dialog_playback.connect(_on_entering_dialog_playback)
	DialogManager.exiting_dialog_playback.connect(_on_obtain_mask)

	_update_visual()
	_on_obtain_mask() 
	# To load default visibility

func _on_entering_dialog_playback():
	visible = false

func _on_obtain_mask() -> void:
	visible = GameState.has_pepsi_mask()
	button_pressed = GameState.is_wearing_pepsi_mask()
		

func _on_toggled(is_pressed: bool) -> void:
	# Block toggle during dialog
	var dialog_mgr = get_tree().current_scene.get_node_or_null("GameUI/DialogManager")
	if dialog_mgr and dialog_mgr.playing:
		button_pressed = not is_pressed  # Revert
		return

	if is_pressed:
		GameState.put_on_mask()
	else:
		GameState.remove_mask()
		
	_update_visual()

func _update_visual() -> void:
	# Visual feedback for mask state
	if GameState.is_wearing_pepsi_mask():
		modulate = Color(0.5, 1.0, 0.5)  # Green tint when wearing
	else:
		modulate = Color.WHITE
