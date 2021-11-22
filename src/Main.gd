extends Node2D

export var sprite_fx: PackedScene

func _ready() -> void:
	Events.connect("score", self, "_create_score_fx")
	
	
func _create_score_fx(msg: Dictionary) -> void:
	var new_sprite_fx := sprite_fx.instance()
	
	add_child(new_sprite_fx)
	new_sprite_fx.setup_vfx(msg.global_position, msg.score)
