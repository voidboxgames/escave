extends Node2D

export(Color, RGB) var clear_color
onready var respawn_position = $Trigger/Respawns/R1.position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	VisualServer.set_default_clear_color(clear_color)
	print(_get_camera_center())
	pass # Replace with function body.

func _get_camera_center():
	var vtrans = get_canvas_transform()
	var top_left = -vtrans.get_origin() / vtrans.get_scale()
	var vsize = get_viewport_rect().size
	return top_left + 0.5*vsize/vtrans.get_scale()

func _on_R1_right_body_entered(body: Node) -> void:
	if body is Player:
		if $YSort/Room1.current:
			respawn_position = $Trigger/Respawns/R2.position
			$YSort/Room2.current = true

		elif $YSort/Room2.current:
			respawn_position = $Trigger/Respawns/R1.position
			$YSort/Room1.current = true


func _on_Player_dead() -> void:
	$YSort/Player.position = respawn_position


func _on_Area2D_body_entered(body: Node) -> void:
	if body is Player:
		$Monolog.play("bottomless")
