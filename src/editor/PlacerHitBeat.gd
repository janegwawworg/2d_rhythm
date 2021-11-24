tool
extends Node2D

class_name PlacerHitBeat, "res://src/editor/placer_hit_beat_icon.svg"

export var scene: PackedScene
export (int, 1, 4) var duration := 2 setget set_duration

var _order_number := 1


func set_duration(value: int) -> void:
	duration = value
	$Sprite.frame = duration - 1


func _enter_tree() -> void:
	_order_number = get_index() + 1
	$LabelCustom.text = str(_order_number)
	
	
func get_data() -> Dictionary:
	return {
		scene = scene,
		order_number = _order_number,
		global_position = global_position,
		duration = duration
	}
