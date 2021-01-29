extends Node2D

export(Color, RGB) var clear_color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	VisualServer.set_default_clear_color(clear_color)
	pass # Replace with function body.

func _on_R1_right_body_entered(body: Node) -> void:
	if body is Player:
		if $YSort/Room1.current:
			$YSort/Room2.current = true
		else:
			$YSort/Room1.current = true



func _on_Player_dead() -> void:
	get_tree().reload_current_scene()
