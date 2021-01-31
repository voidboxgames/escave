extends Node2D

var Explode = preload("res://assets/scenes/effects/ExplodeBlue.tscn")

func _on_HitBox_body_entered(body: Node) -> void:
	if body is Player:
		var parent = get_parent()
		parent.get_node("PickupSound").play()
		body.gain_power(get_parent().power)
		var explode = Explode.instance()
		explode.position = position
		parent.add_child(explode)
		get_parent().emit_signal("collected")
		queue_free()
