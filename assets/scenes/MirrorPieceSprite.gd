extends Node2D

var Explode = preload("res://assets/scenes/effects/ExplodeBlue.tscn")

func _on_HitBox_body_entered(body: Node) -> void:
	if body is Player:
		body.gain_power(get_parent().power)
		var explode = Explode.instance()
		explode.position = position
		get_parent().add_child(explode)
		queue_free()
