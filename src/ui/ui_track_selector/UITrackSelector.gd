extends Control

var _current_track_data: TrackData

onready var _track_name := $TrackName
onready var _stream := $AudioStreamPlayer
onready var _anim_play := $AnimationPlayer


func _ready() -> void:
	update_track_info($TrackCarousel/TrackTiles.get_child(0))
	
	
func update_track_info(track_tile: TrackTile) -> void:
	_current_track_data = track_tile.track_data
	_track_name.text = _current_track_data.label
	
	_anim_play.play("fade_out_track")
	yield(_anim_play, "animation_finished")
	_stream.stream = load(_current_track_data.stream)
	_stream.play(30.0)
	_anim_play.play("fade_in_track")


func _on_GoButton_pressed() -> void:
	Events.emit_signal("track_selected", _current_track_data.as_dict())
	queue_free()
