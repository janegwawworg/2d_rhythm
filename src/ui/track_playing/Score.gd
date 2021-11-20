extends Label

var total_score := 0


func _ready() -> void:
	Events.connect("score", self, "set_play_score")
	
	
func set_play_score(msg: Dictionary) -> void:
	total_score += msg.score
	text = str(total_score)
