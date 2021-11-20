extends Node2D

export var order_number := 0 setget set_order_number

var _missed_score := 0
var _perfect_score := 10
var _great_score := 5
var _ok_score := 3

var _radius_start := 150.0
var _radius_perfect := 70.0
var _radius = _radius_start

var _offset_perfect := 4
var _offset_great := 8
var _offset_ok := 16

var _hit_beat := false
var _speed := 0.0
var _beat_delay := 4.0

onready var _sprite := $Sprite
onready var _area2d := $Area2D
onready var _animate := $AnimationPlayer
onready var _label := $LabelCustom


func _ready() -> void:
	_animate.play("show")


func _process(delta: float) -> void:
	if _hit_beat:
		return
		
	_radius -= delta * _speed * (_radius_start - _radius_perfect)
	if _radius <= _radius_perfect - _offset_perfect:
		_area2d.collision_layer = 0
		Events.emit_signal("score", {"score": 0, "global_position": global_position})
		_animate.play("destroy")
		_hit_beat = true


func set_order_number(order: int) -> void:
	order_number = order
	_label.text = str(order_number)


func setup(data: Dictionary) -> void:
	self.order_number = data.half_beat
	global_position = data.global_position
	_sprite.frame = data.color
	_speed = 1.0 / data.bps / _beat_delay


func _get_score() -> int:
	if abs(_radius_perfect - _radius) < _offset_perfect:
		return _perfect_score
	if abs(_radius_perfect - _radius) < _offset_great:
		return _great_score
	if abs(_radius_perfect - _radius) < _offset_ok:
		return _ok_score
	return 0


func _on_Area2D_input_event(viewport, event, shape_idx) -> void:
	if event.is_action_pressed("touch"):
		_hit_beat = true
		_area2d.collision_layer = 0
		_animate.play("destroy")
		Events.emit_signal("score", {"score": _get_score(), "global_position": global_position})
