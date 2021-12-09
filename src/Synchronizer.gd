extends Node

export var bpm := 124

var _bps := 60.0 / bpm
var _hbps := _bps * 0.5
var _half_last_beat := 0

onready var _stream := $AudioStreamPlayer2D


func _ready() -> void:
	Events.connect("track_selected", self, "_load_track")


func play_audio() -> void:
	var time_delay := AudioServer.get_output_latency() + AudioServer.get_time_to_next_mix()
	yield(get_tree().create_timer(time_delay), "timeout")

	_stream.play()


func _process(delta) -> void:
	var time: float= (
		_stream.get_playback_position() + 
		AudioServer.get_time_since_last_mix() - 
		AudioServer.get_output_latency()
	)
	var half_beat := int(time / _hbps)
	
	if half_beat > _half_last_beat:
		_half_last_beat = half_beat
		Events.emit_signal("beat_incremented", {"half_beat": half_beat, "bps": _bps})

func _load_track(msg: Dictionary) -> void:
	_stream.stream = load(msg.stream)
	bpm = msg.bpm
	_bps = 60.0 / bpm
	_hbps = _bps * 0.5
	play_audio()
