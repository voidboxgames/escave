extends Node2D

export var startTime = 1.0

onready var timer = $Timer
onready var animation_plaer = $AnimationPlayer

func _ready() -> void:
	if startTime == 0:
		_start_fireball()
		return
	timer.wait_time = startTime
	timer.start()

func _on_Area2D_body_entered(body: Node) -> void:
	if body is Player:
		body.die()

func _on_Timer_timeout() -> void:
	_start_fireball()

func _start_fireball() -> void:
	animation_plaer.play("fly")
