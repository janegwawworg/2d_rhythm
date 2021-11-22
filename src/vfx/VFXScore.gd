extends Position2D

var _FRAME_PERFECT := 3
var _FRAME_GREAT := 2
var _FRAME_OK := 1

onready var _sprite := $Sprite
onready var _particles := $Particles2D


func _ready() -> void:
	set_as_toplevel(true)
	
	
func setup_vfx(global_pos: Vector2, score: int) -> void:
	global_position = global_pos
	if score >= 10:
		_sprite.frame = _FRAME_PERFECT
		_particles.emitting = true
	elif score >= 5:
		_sprite.frame = _FRAME_GREAT
	elif score >= 3:
		_sprite.frame = _FRAME_OK
