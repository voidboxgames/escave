extends Control

var current_anim = 1
var max_anim = 6

func _ready() -> void:
	BackgroundMusic.stream_paused = true

func _unhandled_input(_event: InputEvent) -> void:
	if current_anim == max_anim:
		get_tree().change_scene("res://assets/scenes/Intro.tscn")

func next() -> void:
	if current_anim != max_anim:
		current_anim += 1
	$AnimationPlayer.play("a"+current_anim as String)
