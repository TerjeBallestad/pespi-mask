extends Node

signal putting_on_mask
signal removing_mask

@export
var _wearing_pepsi_mask := false

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
