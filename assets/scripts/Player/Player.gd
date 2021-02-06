extends KinematicBody2D

class_name Player

export var max_speed = 100
export var current_max_speed = 20
export(float) var dash_multiplier = 4.0
export(int) var max_dashes = 0
export var jump_force = 205
export var gravity = 600
export(float, 0.0, 1.0) var acceleration = 0.2
export(float, 0.0, 1.0) var friction = 0.6
export var can_jump = false

onready var animations: AnimationPlayer = $AnimationPlayer
onready var body: = $Body
onready var state_machine = $StateMachine
onready var hurt_box_collision = $HurtBox/CollisionShape2D

var velocity = Vector2.ZERO
var direction = Vector2.ZERO
var last_direction = Vector2.RIGHT
var current_dashes: int = 0

signal dash
signal dead(player)

enum powers {
	NONE,
	JUMP,
	DASH,
	DOUBLE_DASH,
	WALK_NORMAL
}

func can_dash() -> bool:
	return current_dashes < max_dashes

func update_direction_input() -> void:
	direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	if direction != Vector2.ZERO:
		last_direction = direction

func calculate_x_velocity(vel: Vector2, direction_x: float) -> Vector2:
	body.flip(direction_x)
	return Vector2 (
		lerp(vel.x, direction_x * current_max_speed, friction if direction_x == 0.0  else acceleration),
		vel.y
	)

func die():
	_disable(true)
	emit_signal("dead", self)

func respawn(pos: Vector2):
	global_position = pos
	_disable(false)

func _disable(value: bool) -> void:
	hurt_box_collision.set_deferred("disabled", value)
	state_machine.disabled = value
	body.visible = !value


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

func _on_StateMachine_transitioned(_old_state, new_state) -> void:
	match new_state:
		"Dash":
			emit_signal("dash")

func _on_HurtBox_body_entered(_body: Node) -> void:
	die()


func _on_HurtBox_area_entered(area: Area2D) -> void:
	die()
