extends Node




func _on_Dash_collected() -> void:
	get_parent().current_respawn = get_parent().get_node("YSort/Rooms/Room13/Respawns/R2")
	get_parent().get_node("Monolog").play("can_dash")


func _on_DoubleDash_collected() -> void:
	get_parent().get_node("Monolog").play("can_ddash")


func _on_FastWalk_collected() -> void:
	get_parent().get_node("Monolog").play("can_walk_fast")


func _on_MirrorPiece_Jump_collected() -> void:
	get_parent().get_node("Monolog").play("can_jump")
