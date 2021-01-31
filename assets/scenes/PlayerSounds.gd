extends Node

onready var _jump = $Jump
onready var _dash = $Dash

func jump() -> void:
	rand(_jump).play()

func dash() -> void:
	rand(_dash).play()

func rand(audio: AudioStreamPlayer) -> AudioStreamPlayer:
	audio.pitch_scale = rand_range(0.8, 1.2)
	return audio
