extends Node2D

export(Player.powers) var power

onready var sound = $PickupSound
onready var mirror_body = $Body

var Explode = preload("res://assets/scenes/effects/ExplodeBlue.tscn")

signal collected

func _on_HitBox_body_entered(body: Node) -> void:
	if body is Player:
		mirror_body.visible = false
		sound.play()
		var explode = Explode.instance()
		add_child(explode)
		yield(explode, "done")
		emit_signal("collected")
		body.gain_power(power)
		queue_free()
