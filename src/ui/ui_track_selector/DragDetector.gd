extends Area2D
class_name DragDetector

signal dragged(amount)

export var strength := 2.0


func _on_Area2D_input_event(viewport, event, shape_idx) -> void:
	if event is InputEventMouseMotion and Input.is_action_pressed("touch"):
		emit_signal("dragged", event.relative * strength)
