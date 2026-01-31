class_name CrawlingText extends RichTextLabel

@export
var letters_per_second := 10.0

func _ready() -> void:
	visible_characters = 0
	while true:
		visible_characters += 1
		await get_tree().create_timer(1 / letters_per_second).timeout

func crawl(text: String) -> void:
	self.text = text
	visible_characters = 0
