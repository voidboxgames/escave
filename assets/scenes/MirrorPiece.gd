extends Sprite

class_name MirroPiece

var Explode = preload("res://assets/scenes/effects/ExplodeBlue.tscn")

export(String) var Name = "unknown_power"

func _ready() -> void:
	pass # Replace with function body.

func _on_HitBox_body_entered(body: Node) -> void:
	if body is Player:
		body.gain_power(Name)
		var explode = Explode.instance()
		explode.position = position
		get_parent().add_child(explode)
		queue_free()
