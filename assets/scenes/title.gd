extends Control

func _ready() -> void:
	BackgroundMusic.autoplay = true
	BackgroundMusic.stream_paused = false

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and !$AnimationPlayer.get_current_animation() == "fade":
		$AnimationPlayer.play("crack")

func start_game() -> void:
	get_tree().change_scene("res://assets/scenes/Testworld.tscn")
