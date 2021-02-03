extends Node

onready var current_room: Room
onready var player = get_parent().get_node("Player")

func _find_current_room() -> Room:
	for room in get_children():
		room.test = 1
		print(room.test)
		if room is Room and room.get_rect().has_point(player.position):
			return room
	return null

func _switch_room(room: Room):
	current_room = room
	room.activate()

func _on_CheckTimer_timeout() -> void:
	var room = _find_current_room()
	if room != current_room and room != null:
		_switch_room(room)
