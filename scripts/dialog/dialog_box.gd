class_name DialogBox extends Control

signal choice_made(box: DialogBox, manager: DialogManager, choice_index: int)

@onready
var _original_y := position.y

## Reference to DialogManager - found as sibling node
var dialog_manager: DialogManager

@export
var slide_animation_duration := 1.0

@export_group("UI Elements")
@export
var speaker_label: RichTextLabel

@export
var portrait_rect: TextureRect

@export
var text_label: CrawlingText

@export
var options_buttons: Array[Button]

func _ready():
	# DialogManager is a sibling node in game_ui.tscn
	dialog_manager = get_parent().get_node("DialogManager")

	dialog_manager.entering_dialog_playback.connect(_on_entering_dialog_playback)
	dialog_manager.entering_dialog.connect(_on_entering_dialog)
	dialog_manager.exiting_dialog.connect(_on_exiting_dialog)
	dialog_manager.exiting_dialog_playback.connect(_on_exiting_dialog_playback)

	for i in len(options_buttons):
		options_buttons[i].button_up.connect(func():
			choice_made.emit(self, dialog_manager, i)
		)

	position.y = _original_y + size.y

func _process(delta: float):
	if dialog_manager.playing:
		dialog_manager.current_dialog.process(delta, dialog_manager)

func _on_entering_dialog_playback():
	slide_in()

func _on_entering_dialog(dialog: Dialog):
	dialog.on_display(self, dialog_manager)

func _on_exiting_dialog(dialog: Dialog):
	dialog.on_hide(self, dialog_manager)

func _on_exiting_dialog_playback():
	slide_out()

func slide_in():
	create_tween().tween_property(self, "position:y", _original_y, slide_animation_duration)

func slide_out():
	create_tween().tween_property(self, "position:y", _original_y + size.y, slide_animation_duration)
