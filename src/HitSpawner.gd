extends Node

export var enable := true
export var hit_beat: PackedScene


func _ready() -> void:
	Events.connect("beat_incremented", self, "_spawner_beat")
	
	
func _spawner_beat(msg: Dictionary) -> void:
	
	if not enable:
		return
	
	if msg.half_beat % 2:
		return
		
	var beat: Dictionary = {}
	beat.half_beat = msg.half_beat
	beat.color = int(rand_range(0, 5))
	beat.global_position = Vector2(rand_range(0, 1920), rand_range(0, 1080))
	beat.bps = msg.bps
	
	var new_beat: Node = hit_beat.instance()
	add_child(new_beat)
	
	new_beat.setup(beat)
