extends PlayerState

func enter(_msg : = {}) -> void:
	player.animations.play("run")

func physics_update(delta: float) -> void:
	player.update_direction_input()

	if not player.is_on_floor():
		state_machine.transition_to("Air", {coyote = true})
		return

	if Input.is_action_just_pressed("dash") && player.can_dash():
		state_machine.transition_to("Dash", {from = "Run"})
		return

	if Input.is_action_just_pressed("jump") && player.can_jump:
		state_machine.transition_to("Air", {do_jump = true})
		return

	if player.direction.x == 0.0:
		state_machine.transition_to("Idle")
		return

	player.velocity = player.calculate_x_velocity(player.velocity, player.direction.x)
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
