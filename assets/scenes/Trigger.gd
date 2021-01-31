extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _on_Area2D_body_shape_entered(body_id: int, body: Node, body_shape: int, area_shape: int) -> void:
	if body is Player:
		get_parent().get_node("Bridges/Bridge").queue_free()


func _on_Bridge1Trigger2_body_shape_entered(body_id: int, body: Node, body_shape: int, area_shape: int) -> void:
	if body is Player:
		get_parent().get_node("Bridges/Bridge2").queue_free()
