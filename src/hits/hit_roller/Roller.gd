extends Area2D

var _score := 0
var _is_entered_roll := false
var _poll_time := 0.0
var _poll_amount := 10

onready var _sprite := $Sprite
onready var _timer := $Timer
onready var _tween := $Tween


func _ready() -> void:
	_sprite.scale = Vector2.ZERO


func setup(beats_per_second: float, duration: float, color: int) -> void:
	_poll_time = beats_per_second * duration / 2.0 / _poll_amount
	_sprite.frame = color


func activate() -> void:
	_tween.interpolate_property(
		_sprite, "scale", Vector2.ZERO, Vector2.ONE, 0.2, Tween.TRANS_BACK, Tween.EASE_OUT
	)
	_tween.start()
	_timer.start(_poll_time)


func submit_score() -> void:
	Events.emit_signal("score", { "score": _score, "global_position": global_position})


func _on_Roller_mouse_entered():
	_is_entered_roll = true


func _on_Roller_mouse_exited():
	_is_entered_roll = false


func _on_Timer_timeout():
	if _is_entered_roll && Input.is_action_pressed("touch"):
		_score += 1
