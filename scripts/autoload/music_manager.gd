extends Node2D

var current_cue = null

var music_player : AudioStreamPlayer = null
var music_playback : AudioStreamPlaybackInteractive = null

func play_music(music_track : Music_Track):
	if music_track.instance_slots_left():
		if music_player == null:
			music_player = AudioStreamPlayer.new()
			
		add_child(music_player)
		music_player.stream = music_track.waveforms
		var bus_index : Music_Track.AUDIO_BUS = music_track.bus
		music_player.bus = Music_Track.AUDIO_BUS.keys()[bus_index]
		
		#music_player.finished.connect(music_track.instance_decrement)
		#music_player.finished.connect(music_player.queue_free)
		music_player.play()
		music_playback = music_player.get_stream_playback()

		
		
		#track.volume_db = music_track.volume
		#music_playback.stream = track
		#music_playback.play()

		#track.play()
		
func change_track(clip_name):
	# Can be "muzak", "elevator_muzak", or "real"
	if music_playback != null:
		music_playback.switch_to_clip_by_name(clip_name)
	
