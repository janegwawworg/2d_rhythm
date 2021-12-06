extends Node2D

export (Array, Resource) var tracks: Array
export var track_tile_scene: PackedScene
export var seperation := 450

var _track_tiles := []


func _ready() -> void:
	_generate_tiles()
	
	
func _generate_tiles() -> void:
	var offset := 0.0
	
	for i in tracks.size():
		var track_data: TrackData = tracks[i]
		var track_tile: TrackTile = track_tile_scene.instance()
		
		track_tile.track_data = track_data
		_track_tiles.append(track_tile)
		
		track_tile.position = Vector2(offset, 0)
		offset += seperation
		
		add_child(track_tile)
