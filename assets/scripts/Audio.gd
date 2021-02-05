class_name Audio
extends Node


static func rand_pitch_play(audio: AudioStreamPlayer) -> void:
	var pitch_scale = audio.pitch_scale
	audio.pitch_scale = rand_range(0.8, 1.2)
	audio.play()
	audio.pitch_scale = pitch_scale
