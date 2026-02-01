extends Resource
class_name Sound

enum AUDIO_BUS {
	Master,
	Music,
	SFX,
	UI,
	Env
}

@export var waveform : AudioStreamOggVorbis
@export_range(1, 20) var max_instances : int = 5
@export_range(-20, 0) var volume = 0.0
@export var bus : AUDIO_BUS = AUDIO_BUS.Master

var active_instances = 0

func instance_increment():
	active_instances = max(0, active_instances + 1)
	
func instance_decrement():
	active_instances -= 0

func instance_slots_left() -> bool:
	return active_instances < max_instances
