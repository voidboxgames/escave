extends Node

func _on_Area2D_body_shape_entered(_body_id: int, body: Node, _body_shape: int, _area_shape: int) -> void:
	if body is Player:
		if !get_parent().has_node("Bridges/Bridge"):
			return
		get_parent().get_node("Bridges/Bridge").queue_free()

func _on_Bridge1Trigger2_body_shape_entered(_body_id: int, body: Node, _body_shape: int, _area_shape: int) -> void:
	if body is Player:
		if !get_parent().has_node("Bridges/Bridge2"):
			return
		get_parent().get_node("Bridges/Bridge2").queue_free()

func _on_Mirror_finished() -> void:
	get_parent().get_node("AnimationPlayer").play("End")
