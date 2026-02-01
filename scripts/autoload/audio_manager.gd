extends Node2D

func play_sound(sound : Sound):
	# Use this for in-game sounds.
	if sound.instance_slots_left():
		var sound_effect = AudioStreamPlayer2D.new()
		add_child(sound_effect)
		sound_effect.stream = sound.waveform
		var bus_index : Sound.AUDIO_BUS = sound.bus
		sound_effect.bus = Sound.AUDIO_BUS.keys()[bus_index]
		sound_effect.volume_db = sound.volume
		sound_effect.finished.connect(sound.instance_decrement)
		sound_effect.finished.connect(sound_effect.queue_free)
		sound_effect.play()
	
func play_sound_at_location(sound : Sound, location):
	# Use this for in-game sounds.
	if sound.instance_slots_left():
		var sound_effect = AudioStreamPlayer2D.new()
		add_child(sound_effect)
		sound_effect.stream = sound.waveform
		sound_effect.stream = sound.waveform
		var bus_index : Sound.AUDIO_BUS = sound.bus
		sound_effect.position = location
		sound_effect.volume_db = sound.volume
		sound_effect.finished.connect(sound.instance_decrement)
		sound_effect.play()
