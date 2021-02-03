extends Node2D

export(Color, RGB) var clear_color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BackgroundMusic.autoplay = true
	BackgroundMusic.stream_paused = false
	BackgroundMusic.play()#
	VisualServer.set_default_clear_color(clear_color)
	pass # Replace with function body.
