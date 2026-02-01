class_name ExitPoint extends ClickableObject

@export var target_scene: String = ""
@export_node_path("Marker2D") var walk_target_path: NodePath = "WalkTarget"

var walk_target: Marker2D

func _ready() -> void:
	super._ready()
	object_interacted_with.connect(_on_interacted)

func _on_interacted(_name: String) -> void:
	SceneTransition.change_scene(target_scene)
