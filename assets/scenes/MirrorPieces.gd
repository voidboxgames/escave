extends Node




func _on_Dash_collected() -> void:
	get_parent().get_node("Monolog").play("can_dash")


func _on_DoubleDash_collected() -> void:
	get_parent().get_node("Monolog").play("can_ddash")


func _on_FastWalk_collected() -> void:
	get_parent().get_node("Monolog").play("can_walk_fast")
