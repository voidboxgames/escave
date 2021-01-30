extends KinematicBody2D

class_name Player

export var max_speed = 125
export(int) var max_jumps = 1
export var jump_force = 250
export var gravity = 800
export(float, 0.0, 1.0) var acceleration = 0.5

export var can_walk = true
export var can_jump = false

var velocity = Vector2.ZERO
var direction = Vector2.LEFT

signal dead

enum powers {
	NONE,
	JUMP
}

func _process(delta: float) -> void:
	deadCheck()

func _apply_movement() -> void:
	velocity = move_and_slide(velocity, Vector2.UP)

func _apply_gravity(delta) -> void:
	velocity.y += gravity * delta

func _handle_move_input() -> void:
	direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	velocity.x = lerp(velocity.x , direction.x * max_speed, acceleration)
	if direction.x != 0:
		$Body.scale.x = direction.x

func die() -> void:
	emit_signal("dead")

func gain_power(power) -> void:
	print("new power")
	match power:
		powers.JUMP:
			print("can_jump")
			can_jump = true

func deadCheck() -> void:
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.is_in_group("deadly"):
			die()
