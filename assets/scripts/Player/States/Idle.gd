extends PlayerState

func enter(_msg := {}) -> void:
	player.animations.play("idle")

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("dash") && player.can_dash():
		state_machine.transition_to("Dash", {from = "Idle"})
	elif event.is_action_pressed("jump") && player.can_jump:
		state_machine.transition_to("Air", {do_jump = true})

func update(_delta: float) -> void:
	player.update_direction_input()
	if not player.is_on_floor():
		state_machine.transition_to("Air")
	elif player.direction != Vector2.ZERO:
		state_machine.transition_to("Run")

func physics_update(delta: float) -> void:
	player.velocity.y += player.gravity * delta
	player.velocity = player.calculate_x_velocity(player.velocity, player.direction.x)
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP, true)
