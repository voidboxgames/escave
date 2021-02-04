extends Node2D

onready var sprite:  = $Sprite

func flip(direction_x: float) -> void:
	if direction_x < 0:
		sprite.flip_h = true
	elif direction_x > 0:
		sprite.flip_h = false
