extends KinematicBody2D

class_name Player

export var max_speed = 100
export var current_max_speed = 15
export(float) var dash_multiplier = 4.0
export(int) var max_dashes = 0
export var jump_force = 205
export var gravity = 600
export(float, 0.0, 1.0) var acceleration = 0.2
export(float, 0.0, 1.0) var friction = 0.6
export var can_jump = false

onready var animations: AnimationPlayer = $AnimationPlayer
onready var body: = $Body
onready var collision_shape = $CollisionShape2D

var velocity = Vector2.ZERO
var direction = Vector2.ZERO
var last_direction = Vector2.RIGHT
var current_dashes: int = 0

signal dead(Player)
signal dash

enum powers {
	NONE,
	JUMP,
	DASH,
	DOUBLE_DASH,
	WALK_NORMAL
}

func _process(_delta: float) -> void:
	deadCheck()

func can_dash() -> bool:
	return current_dashes < max_dashes

func update_direction_input() -> void:
	direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	if direction != Vector2.ZERO:
		last_direction = direction

func deadCheck() -> void:
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.is_in_group("deadly"):
			die()

func calculate_x_velocity(vel: Vector2, direction_x: float) -> Vector2:
	body.flip(direction_x)
	return Vector2 (
		lerp(vel.x, direction_x * current_max_speed, friction if direction_x == 0.0  else acceleration),
		vel.y
	)

func die() -> void:
	emit_signal("dead", self)

func respawn(pos: Vector2):
	global_position = pos

func gain_power(power) -> void:
	match power:
		powers.JUMP:
			can_jump = true
		powers.DASH:
			max_dashes = 1
		powers.DOUBLE_DASH:
			max_dashes = 2
		powers.WALK_NORMAL:
			current_max_speed = max_speed

func _on_PlayerStateMachine_dash() -> void:
	emit_signal("dash")
