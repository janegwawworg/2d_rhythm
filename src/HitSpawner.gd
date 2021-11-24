extends Node

export var enable := true
export var hit_beat: PackedScene

var _stack_current := []


func _ready() -> void:
	Events.connect("beat_incremented", self, "_spawner_beat")
	_generate_stack()


func _generate_stack() -> void:
	for i in range(10):
		var hit_beat_data := {}
		if i % 2 == 1:
			hit_beat_data.color = int(rand_range(0, 5))
			hit_beat_data.global_position = i * Vector2(100, 100)
		_stack_current.append(hit_beat_data)


func _spawner_beat(msg: Dictionary) -> void:
	if not enable:
		return
	
	if _stack_current.empty():
		enable = false
		Events.emit_signal("track_finished")
		return
		
	var hit_beat_data: Dictionary= _stack_current.pop_front()
	
	if not hit_beat_data.has("global_position"):
		return
		
	hit_beat_data.bps = msg.bps
	hit_beat_data.half_beat = msg.half_beat
	
	var new_beat: Node = hit_beat.instance()
	add_child(new_beat)
	
	new_beat.setup(hit_beat_data)
