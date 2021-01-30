extends KinematicBody2D

class_name Player

export var max_speed = 100
export(float) var dash_multiplier = 4.0
export(int) var max_dashes = 0
export var jump_force = 200
export var gravity = 600
export(float, 0.0, 1.0) var acceleration = 0.5
export(bool) var gravity_enabled = true

export var can_jump = false

var velocity = Vector2.ZERO
var direction = Vector2.LEFT

signal dead
signal dash

enum powers {
	NONE,
	JUMP,
	DASH,
	DOUBLE_DASH
}

func _process(delta: float) -> void:
	deadCheck()

func _apply_movement() -> void:
	if gravity_enabled:
		velocity = move_and_slide(velocity, Vector2.UP)

func _apply_gravity(delta) -> void:
	if gravity_enabled:
		velocity.y += gravity * delta

func _handle_move_input() -> void:
	if !gravity_enabled:
		return
	direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	if direction.x != 0:
		$Body.scale.x = direction.x
	velocity.x = lerp(velocity.x , direction.x * max_speed, acceleration)

func _handle_dash_input() -> void:
	if !gravity_enabled:
		return
	velocity = direction.normalized() * max_speed * dash_multiplier
	velocity = move_and_slide(velocity, Vector2.ZERO)

func die() -> void:
	$AnimationPlayer.play("death")

func dead() -> void:
	emit_signal("dead")

func respawn(pos: Vector2) -> void:
	position = pos
	$AnimationPlayer.play("respawn")

func gain_power(power) -> void:
	match power:
		powers.JUMP:
			can_jump = true
		powers.DASH:
			max_dashes = 1
		powers.DOUBLE_DASH:
			max_dashes = 2

func deadCheck() -> void:
	if gravity_enabled:
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision.collider.is_in_group("deadly"):
				die()
