extends Control
@onready var audio_test_scene: Control = $"."
@onready var button: Button = $Panel/Button

@export var music : Music_Track
@export var soundUIHover : Sound
@export var soundUIClick : Sound

func _on_button_button_down() -> void:
	print("hover")
	AudioManager.play_sound(soundUIClick)
	MusicManager.play_music(music)

func _on_button_mouse_entered() -> void:
	print("hover")
	AudioManager.play_sound(soundUIHover)


func _on_btn_muzak_button_down() -> void:
	MusicManager.change_track("muzak")


func _on_btn_dist_button_down() -> void:
	MusicManager.change_track("elevator_muzak")


func _on_btn_real_button_down() -> void:
	MusicManager.change_track("real")
