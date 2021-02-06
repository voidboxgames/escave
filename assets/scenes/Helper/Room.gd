extends Camera2D

class_name Room

export(Color, RGB) var color

onready var rect = _calculate_rect()
#onready var canvasModulate = $Colors

func _calculate_rect() -> Rect2:
	# TODO: more robust screen size enumeratioon
	var _size = Vector2(
		ProjectSettings.get_setting("display/window/size/width"),
		ProjectSettings.get_setting("display/window/size/height")) * zoom
	var _position = Vector2(position - (_size/2))
	return Rect2(_position, _size)

func activate() -> void:
#	canvasModulate.color = color
	make_current()
	update()
