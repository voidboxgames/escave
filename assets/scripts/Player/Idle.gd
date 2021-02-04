extends PlayerState

func enter(_msg := {}) -> void:
	player.animations.play("idle")

func update(_delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return

	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Air", {do_jump = true})
		return

	if Input.is_action_pressed("right") or Input.is_action_pressed("left"):
		state_machine.transition_to("Run")
		return

func physics_update(delta: float) -> void:
	player.velocity.y += player.gravity * delta
	player.velocity = player.calculate_x_velocity(player.velocity, 0.0)
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
