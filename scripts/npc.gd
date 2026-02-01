class_name Npc extends ClickableObject

@export
var normal_dialog: DialogSequence

@export
var pepsi_dialog: DialogSequence

func _ready() -> void:
	super._ready()
	object_interacted_with.connect(_on_interacted)

func _on_interacted(_name: String) -> void:
	var seq := normal_dialog
	
	if GameState.is_wearing_pepsi_mask():
		seq = pepsi_dialog
		
	DialogManager.start_dialog(seq)
