extends Node2D

export(Color, RGB) var clear_color

func _ready() -> void:
	BackgroundMusic.autoplay = true
	BackgroundMusic.stream_paused = false
	BackgroundMusic.play()#
	VisualServer.set_default_clear_color(clear_color)
