extends Node

export var enable := true
export var hit_beat: PackedScene

var _stack_current := []
var _stacks := {}

onready var _patterns := $Patterns


func _ready() -> void:
	Events.connect("beat_incremented", self, "_spawner_beat")
	_generate_stack()
	_select_stack({name = "Cephalopod"})


func _generate_stack() -> void:
	for pattern in _patterns.get_children():
		_stacks[pattern.name] = []
		
		for chunk in pattern.get_children():
			var sprite_frame = round(rand_range(0, 5))
			
			for placer in chunk.get_children():
				var hit_beat_data: Dictionary= placer.get_data()
				hit_beat_data.color = sprite_frame
				_stacks[pattern.name].append(hit_beat_data)
				
				for i in range(hit_beat_data.duration - 1):
					_stacks[pattern.name].append({})
					
	_patterns.queue_free()


func _select_stack(msg: Dictionary) -> void:
	_stack_current = _stacks[msg.name]


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
