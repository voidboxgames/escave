extends KinematicBody2D

export var max_speed = 150
export(int) var max_jumps = 1
export var jump_force = 250
export var gravity = 800
export(float, 0.0, 1.0) var acceleration = 0.5
export(float, 0.0, 1.0) var friction = 0.4

var velocity = Vector2.ZERO
var direction = Vector2.LEFT
var jumps_left: int = 0
var is_jumping = false
var is_jump_button_pressed = false

onready var coyote_timer = $CoyoteTimer
onready var floor_timer = $FloorTimer

func _ready() -> void:
	jumps_left = max_jumps

func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	update_direction()
	move_velocity()
	jump_velocity()
	apply_gravity(delta)
	move()

func apply_gravity(delta) -> void:
	velocity.y += gravity * delta
	if is_jumping && velocity.y >= 0:
		is_jumping = false

func move() -> void:
	var was_on_floor = is_on_floor()
	velocity = move_and_slide(velocity, Vector2.UP)
	if !is_on_floor() and was_on_floor and !is_jumping:
		coyote_timer.start()
	if !was_on_floor and is_on_floor():
		jumps_left = max_jumps

func update_direction() -> void:
	direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)

func move_velocity() -> void:
	if direction == Vector2.ZERO:
		velocity.x = lerp(velocity.x, 0, friction)
		return

	velocity.x = lerp(velocity.x , direction.x * max_speed, acceleration)

func jump_velocity() -> void:
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() or !coyote_timer.is_stopped():
			jump()
		elif jumps_left > 0:
			jump()
		else:
			floor_timer.start()
	if velocity.y < 0 and !Input.is_action_pressed("jump"):
		velocity.y = 0.0

func jump() -> void:
	jumps_left -= 1
	is_jumping = true
	coyote_timer.stop()
	velocity.y = -jump_force

func _on_FloorTimer_timeout() -> void:
	if is_on_floor():
		jump()
