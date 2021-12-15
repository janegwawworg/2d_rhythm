extends Line2D

export var timer_duration := 0.01
export var target_width := 48.0
export var expand_duration := 1.0

var path_points := []

onready var _timer := $Timer
onready var _tween := $Tween


func setup(curve: PoolVector2Array) -> void:
	path_points = curve
	
	clear_points()


func start() -> void:
	_timer.start(timer_duration)
	
	_tween.interpolate_property(
		self, "width", 0, target_width, expand_duration, Tween.TRANS_LINEAR
	)
	_tween.start()


func _on_Timer_timeout():
	if not path_points:
		_timer.stop()
		return
	add_point(path_points.pop_front())
