extends Control

func _ready() -> void:
	$RichTextLabel2.visible = true

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and !$AnimationPlayer.get_current_animation() == "fade":
		$RichTextLabel2.visible = false
		$AnimationPlayer.play("crack")

func start_game() -> void:
	get_tree().change_scene("res://assets/scenes/Testworld.tscn")
