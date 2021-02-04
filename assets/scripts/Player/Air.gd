extends PlayerState

onready var jump_timer: Timer = $JumpTimer
onready var coyote_timer = $CoyoteTimer

func enter(msg := {}) -> void:
	player.animations.play("air")
	if msg.has("do_jump"):
		_do_jump()
	if msg.has("coyote"):
		coyote_timer.start()

func physics_update(delta: float) -> void:
	if Input.is_action_just_released("jump") && player.velocity.y < 0:
		player.velocity.y = 0.0

	if Input.is_action_just_pressed("jump"):
		if not coyote_timer.is_stopped():
			_do_jump()
		else:
			jump_timer.start()

	var direction: float =  Input.get_action_strength("right") - Input.get_action_strength("left")
	if player.is_on_floor():
		if not jump_timer.is_stopped():
			_do_jump()
		elif direction == 0.0:
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")

	player.velocity = player.calculate_x_velocity(player.velocity, direction)
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)

func _do_jump():
	player.velocity.y = -player.jump_force
