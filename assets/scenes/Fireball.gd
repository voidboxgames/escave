extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

export var startTime = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.wait_time = startTime
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Area2D_body_entered(body: Node) -> void:
	if body is Player:
		body.die()


func _on_Timer_timeout() -> void:
	$AnimationPlayer.play("fly")
