extends Control

var title = preload("res://assets/scenes/title.tscn")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_pressed():
		_go_to_title()

func _on_Timer_timeout() -> void:
	_go_to_title()

func _go_to_title() -> void:
	var err: = get_tree().change_scene_to(title)
	if err:
		printerr(err)
