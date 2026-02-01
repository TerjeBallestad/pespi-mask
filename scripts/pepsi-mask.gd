class_name PepsiMask extends ClickableObject

func _ready() -> void:
	super._ready()
	object_interacted_with.connect(_on_interacted)

func _on_interacted(_name: String):
	GameState.obtain_pepsi_mask()
	GameState.put_on_mask()
	queue_free()
