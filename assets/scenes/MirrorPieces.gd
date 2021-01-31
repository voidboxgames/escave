extends Node




func _on_Dash_collected() -> void:
	get_parent().get_node("Monolog").play("can_dash")
