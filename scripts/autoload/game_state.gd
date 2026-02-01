extends Node

var current_act: int = 1
var clues: Dictionary = {}
var flags: Dictionary = {}
var dialog_history: Dictionary = {}
var _wearing_pepsi_mask := false

signal putting_on_mask
signal removing_mask

func is_wearing_pepsi_mask() -> bool:
	return _wearing_pepsi_mask
	
func put_on_mask():
	if is_wearing_pepsi_mask():
		return
		
	_wearing_pepsi_mask = true
	putting_on_mask.emit()
	pass
	
func remove_mask():
	if not is_wearing_pepsi_mask():
		return
	
	_wearing_pepsi_mask = false
	removing_mask.emit()
	pass

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
