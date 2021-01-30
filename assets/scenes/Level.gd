extends Node2D

export(Color, RGB) var clear_color
onready var current_room = $YSort/Rooms/Room1
onready var current_respawn = $YSort/Rooms/Room1/Respawns/R1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	VisualServer.set_default_clear_color(clear_color)
	pass # Replace with function body.

func _on_Player_dead() -> void:
	$YSort/Player.position = current_respawn.position

func _on_Area2D_body_entered(body: Node) -> void:
	if body is Player:
		$Monolog.play("bottomless")

func _find_nearest_respawn() -> void:
	var last_distance: float = 1000000
	var nearest_respawn = null
	for respawn in current_room.get_node("Respawns").get_children():
		var distance = respawn.get_position().distance_to($YSort/Player.position)
		if distance < last_distance:
			nearest_respawn = respawn
			last_distance = distance

		if nearest_respawn != current_respawn && nearest_respawn != null:
			current_respawn = nearest_respawn

func _on_Roomchecker_timeout() -> void:
	var last_distance: float = 1000000
	var nearest_room = null
	for room in $YSort/Rooms.get_children():
		var distance = room.get_position().distance_to($YSort/Player.position)
		if distance < last_distance:
			nearest_room = room
			last_distance = distance

	if nearest_room != current_room && nearest_room != null:
		current_room = nearest_room
		nearest_room.current = true
		_find_nearest_respawn()



func _on_MoodChange_body_entered(body: Node) -> void:
	if body is Player:
		var c = Color("#e16e1a")
		$CanvasModulate.set_color(c)
