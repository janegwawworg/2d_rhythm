extends Node2D

export var order_number := 0 setget set_order_number

var _hit_beat := false

onready var _sprite := $Sprite
onready var _area2d := $Area2D
onready var _animate := $AnimationPlayer
onready var _label := $LabelCustom


func _ready() -> void:
	_animate.play("show")
	
	
func set_order_number(order: int) -> void:
	order_number = order
	_label.text = str(order_number)


func setup(data: Dictionary) -> void:
	self.order_number = data.half_beat
	global_position = data.global_position
	_sprite.frame = data.color


func _on_Area2D_input_event(viewport, event, shape_idx) -> void:
	if event.is_action_pressed("touch"):
		_hit_beat = true
		_area2d.collision_layer = 0
		_animate.play("destroy")
