extends Control

var current_anim = 1
var max_anim = 6

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:
	if current_anim == max_anim:
		get_tree().change_scene("res://assets/scenes/Intro.tscn")

func next() -> void:
	if current_anim != max_anim:
		current_anim += 1
	$AnimationPlayer.play("a"+current_anim as String)
