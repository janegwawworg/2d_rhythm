extends Path2D

var order_number := 0 setget set_order_number
var _beat_delay := 4.0

onready var _sprite_start := $SpriteStart
onready var _sprite_start_label := $SpriteStart/Label
onready var _sprite_end := $SpriteEnd
onready var _sprite_end_label := $SpriteEnd/Label
onready var _anim_player := $AnimationPlayer
onready var _grow_line := $GrowingLine
onready var _roller := $RollerFollow/Roller
onready var _roller_follow := $RollerFollow


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_anim_player.play("show")


func set_order_number(order: int) -> void:
	order_number = order
	_sprite_start_label.text = str(order_number)
	_sprite_end_label.text = str(order_number + 1)


func setup(data: Dictionary) -> void:
	curve = data.curve
	var curve_points := curve.get_baked_points()
	_sprite_start.position = curve_points[0]
	_sprite_end.position = curve_points[curve_points.size() - 1]
	
	self.order_number = data.order_number
	global_position = data.global_position
	
	_sprite_start.frame = data.color
	_sprite_end.frame = data.color
	
	_grow_line.setup(curve_points)
	_grow_line.start()
	_roller.setup(data.bps, data.duration, data.color)
	_roller_follow.setup(data.bps * _beat_delay, data.bps * data.duration)
	

func destroy() -> void:
	_anim_player.play("destroy")
