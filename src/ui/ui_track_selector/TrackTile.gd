extends Area2D
class_name TrackTile

var track_data: TrackData setget set_track_data


func set_track_data(value: TrackData) -> void:
	track_data = value
	$Sprite.texture = track_data.icon
