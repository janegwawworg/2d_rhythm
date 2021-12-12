extends Control

onready var _anim_player := $AnimationPlayer


func _ready() -> void:
	Events.connect("track_finished", self, "_on_track_finished")


func _on_track_finished() -> void:
	_anim_player.play("fade_in")


func _on_TextureButton_pressed():
	get_tree().reload_current_scene()
