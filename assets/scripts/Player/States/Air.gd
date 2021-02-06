extends PlayerState

onready var jump_timer: Timer = $JumpTimer
onready var coyote_timer = $CoyoteTimer
onready var jump_sound = $Jump

func enter(msg := {}) -> void:
	player.animations.play("air")
	if msg.has("do_jump"):
		_do_jump()
	if msg.has("coyote"):
		coyote_timer.start()

func physics_update(delta: float) -> void:
	player.update_direction_input()

	if Input.is_action_just_released("jump") && player.velocity.y < 0:
		player.velocity.y = 0.0

	if Input.is_action_just_pressed("dash") && player.can_dash():
		state_machine.transition_to("Dash", {from = "Air"})
		return

	if Input.is_action_just_pressed("jump"):
		if not coyote_timer.is_stopped():
			_do_jump()
		else:
			jump_timer.start()

	if player.is_on_floor():
		if not jump_timer.is_stopped():
			_do_jump()
		else:
			player.current_dashes = 0
			if player.direction.x == 0.0:
				state_machine.transition_to("Idle")
				return
			else:
				state_machine.transition_to("Run")
				return

	player.velocity = player.calculate_x_velocity(player.velocity, player.direction.x)
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)

func _do_jump():
	if player.can_jump:
		Audio.rand_pitch_play(jump_sound)
		player.velocity.y = -player.jump_force
