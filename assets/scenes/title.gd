extends Control

func _unhandled_input(event: InputEvent) -> void:
	if !$AnimationPlayer.get_current_animation() == "fade":
		$AnimationPlayer.play("crack")

func start_game() -> void:
	get_tree().change_scene("res://assets/scenes/Testworld.tscn")
