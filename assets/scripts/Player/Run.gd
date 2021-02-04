extends PlayerState

func enter(_msg : = {}) -> void:
	player.animations.play("run")

func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Air", {coyote = true})
		return

	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Air", {do_jump = true})
		return

	var direction: float = Input.get_action_strength("right") - Input.get_action_strength("left")

	if direction == 0:
		state_machine.transition_to("Idle")
		return

	player.velocity = player.calculate_x_velocity(player.velocity, direction)
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
