extends Node2D

export (Array, Resource) var tracks: Array
export var track_tile_scene: PackedScene
export var seperation := 450

var _track_tiles := []
var _min_x_position := 0.0
var _selected_track_tile: TrackTile

onready var _align_timer := $AlignTimer
onready var _tween := $Tween


func _ready() -> void:
	_generate_tiles()
	
	
func _unhandled_input(event) -> void:
	if event.is_action_released("touch"):
		_align_timer.start()


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
	_min_x_position = -(seperation * (_track_tiles.size() - 1))


func _scroll(amount: Vector2) -> void:
	position.x = clamp(position.x + amount.x, _min_x_position, 0)
	_tween.stop_all()


func _on_DragDetector_dragged(amount: Vector2) -> void:
	_scroll(amount)


func _snap_to_track(track_tile: TrackTile) -> void:
	var offset_to_center := Vector2(get_parent().global_position.x - 
	track_tile.global_position.x, 0)
	_tween.interpolate_property(
		self,
		"position",
		position,
		position + offset_to_center,
		0.5,
		Tween.TRANS_EXPO,
		Tween.EASE_OUT
	)
	_tween.start()


func _on_SelectArea_track_selected(track_tile: TrackTile) -> void:
	_selected_track_tile = track_tile


func _on_AlignTimer_timeout() -> void:
	_snap_to_track(_selected_track_tile)
