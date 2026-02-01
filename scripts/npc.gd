class_name Npc extends ClickableObject

## Path to filtered dialog YAML (shown without mask)
@export_file("*.yaml")
var filtered_dialog_path: String

## Path to unfiltered dialog YAML (shown with mask)
@export_file("*.yaml")
var unfiltered_dialog_path: String

## Fallback: pre-assigned dialog resources (for backward compatibility)
@export
var normal_dialog: DialogSequence

@export
var pepsi_dialog: DialogSequence

## Offset from NPC position where player should stand
@export
var talk_offset := Vector2(40, 0)

var _cached_filtered: DialogSequence
var _cached_unfiltered: DialogSequence

func _ready() -> void:
	object_interacted_with.connect(_on_interacted)
	# Pre-cache dialogs if paths are set
	if filtered_dialog_path != "":
		_cached_filtered = DialogParser.parse_dialog_file(filtered_dialog_path)
	if unfiltered_dialog_path != "":
		_cached_unfiltered = DialogParser.parse_dialog_file(unfiltered_dialog_path)

func _on_interacted(_name: String) -> void:
	var player = get_tree().get_first_node_in_group("player")
	if player and player.has_method("walk_to_exit"):
		var talk_pos = global_position + talk_offset
		player.walk_to_exit(talk_pos, _start_dialog)
	else:
		_start_dialog()

func _start_dialog() -> void:
	var seq: DialogSequence

	# Check mask state and select dialog
	if PepsiManager.is_wearing_pepsi_mask():
		seq = _cached_unfiltered if _cached_unfiltered else pepsi_dialog
	else:
		seq = _cached_filtered if _cached_filtered else normal_dialog

	if seq == null:
		push_warning("NPC %s has no dialog for current mask state" % name)
		return

	%DialogManager.start_dialog(seq)

# Visual hover feedback
func _on_mouse_entered() -> void:
	super._on_mouse_entered()
	# Brighten sprite to indicate interactable
	if has_node("Sprite2D"):
		$Sprite2D.modulate = Color(1.2, 1.2, 1.2)
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_mouse_exited() -> void:
	super._on_mouse_exited()
	# Reset sprite
	if has_node("Sprite2D"):
		$Sprite2D.modulate = Color.WHITE
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
