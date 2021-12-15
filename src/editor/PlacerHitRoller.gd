tool
extends Path2D
class_name PlacerHitRoller, "res://src/editor/placer_hit_roller_icon.svg"

export (PackedScene) var scene
export (int, 1, 4) var duration := 4 setget set_duration

var _order_number := 1


func _draw() -> void:
	draw_circle(curve.get_point_position(curve.get_point_count() - 1), 75.0, Color.black)


func set_duration(value: int) -> void:
	duration = value
	$Sprite.frame = duration - 1


func get_data() -> Dictionary:
	return {
		scene = scene,
		order_number = _order_number,
		global_position = global_position,
		duration = duration,
		curve = curve
	}


func _enter_tree() -> void:
	_order_number = get_index() + 1
	$OrderNumber.text = str(_order_number)
	$Sprite.global_position = to_global(curve.get_point_position(0))
