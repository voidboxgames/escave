extends Node

onready var _jump = $Jump
onready var _dash = $Dash
onready var _death = $Death

func jump() -> void:
	_rand(_jump).play()

func dash() -> void:
	_rand(_dash).play()

func death() -> void:
	_rand(_death).play()

func _rand(audio: AudioStreamPlayer) -> AudioStreamPlayer:
	audio.pitch_scale = rand_range(0.8, 1.2)
	return audio
