extends Area2D

export(NodePath) var CameraPath1
export(NodePath) var CameraPath2

onready var Camera1 = get_node(CameraPath1)
onready var Camera2 = get_node(CameraPath2)

func _on_RoomChanger_body_entered(body: Node) -> void:
	if Camera1.current:
		Camera2.current = true
	else:
		Camera1.current = true
