class_name DialogParser extends RefCounted

static func parse_dialog_file(path: String) -> DialogSequence:
	var file = FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("DialogParser: Failed to open file: " + path)
		return null

	var content = file.get_as_text()
	file.close()

	return parse_dialog_string(content, path)


static func parse_dialog_string(content: String, source_path: String = "") -> DialogSequence:
	var json = JSON.new()
	var error = json.parse(content)
	if error != OK:
		push_error("DialogParser: Failed to parse JSON from: " + source_path + " - " + json.get_error_message())
		return null

	var data = json.data
	if data == null or not data is Dictionary:
		push_error("DialogParser: Invalid JSON structure in: " + source_path)
		return null

	return _build_sequence(data)


static func _build_sequence(data: Dictionary) -> DialogSequence:
	var sequence = DialogSequence.new()

	# Create speaker
	var speaker = DialogSpeaker.new()
	speaker.name = data.get("speaker", "Unknown")

	# Load portrait if specified
	var portrait_path = data.get("portrait", "")
	if portrait_path != "":
		if ResourceLoader.exists(portrait_path):
			speaker.portrait = load(portrait_path)
		else:
			push_warning("DialogParser: Portrait not found: " + portrait_path)

	# Build dialog entries
	var entries = data.get("entries", [])
	for entry in entries:
		var dialog = TextDialog.new()
		dialog.speaker = speaker
		dialog.text = entry.get("text", "") if entry is Dictionary else str(entry)
		sequence.dialogs.append(dialog)

	return sequence
