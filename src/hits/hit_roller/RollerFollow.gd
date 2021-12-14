extends PathFollow2D

signal roller_completed

onready var _roller := $Roller
onready var _tween := $Tween


func setup(delay: float, duration: float) -> void:
	yield(get_tree().create_timer(1), "timeout")
	
	_roller.activate()
	_tween.interpolate_property(
		self, "unit_offset", 0, 1, duration, Tween.TRANS_LINEAR, Tween.EASE_OUT
	)
	_tween.start()
	
	yield(_tween, "tween_all_completed")
	emit_signal("roller_completed")
