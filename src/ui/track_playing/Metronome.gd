extends Sprite

onready var tween := $Tween


func _ready() -> void:
	Events.connect("beat_incremented", self, "pulse")
	
	
func pulse(msg) -> void:
	if msg.half_beat % 2 == 1:
		return
	
	var beat_per_second: float = msg.bps
	tween.interpolate_property(
		self, 
		"scale", 
		Vector2.ONE * 1.5, 
		Vector2.ONE, 
		beat_per_second / 4, 
		Tween.TRANS_LINEAR, 
		Tween.EASE_OUT
	)
	tween.start()
