extends Node

var current_act: int = 1
var clues: Dictionary = {}
var flags: Dictionary = {}
var dialog_history: Dictionary = {}


func has_clue(clue_id: String) -> bool:
	return clues.has(clue_id) and clues[clue_id] == true


func collect_clue(clue_id: String) -> void:
	clues[clue_id] = true


func set_flag(flag_id: String, value: bool = true) -> void:
	flags[flag_id] = value


func get_flag(flag_id: String) -> bool:
	return flags.get(flag_id, false)


func is_room_unlocked(room_id: String) -> bool:
	if room_id == "basement":
		return get_flag("unlocked_basement")
	return true
