class_name Npc extends ClickableObject

@export_file_path("*.json")
var normal_dialog_path: String

@export_file_path("*.json")
var pepsi_dialog_path: String

func _ready() -> void:
	super._ready()
	object_interacted_with.connect(_on_interacted)

func _on_interacted(_name: String) -> void:
	var seq_path := normal_dialog_path
	
	if GameState.is_wearing_pepsi_mask():
		seq_path = pepsi_dialog_path
		
	DialogManager.start_dialog(DialogParser.parse_dialog_file(seq_path))
