extends "res://assets/scripts/StateMachine.gd"

onready var coyote_timer = $CoyoteTimer
onready var ground_timer = $GroundTimer
onready var animation_player = parent.get_node("AnimationPlayer")

func _ready() -> void:
	add_state("idle")
	add_state("run")
	add_state("jump")
	add_state("fall")
	call_deferred("set_state", states["idle"])

func _input(event: InputEvent) -> void:
	if animation_player.get_current_animation() == "death":
		return
	if  [states.idle, states.run].has(state):
		if event.is_action_pressed("jump"):
			_jump()
	if state == states.jump:

		if event.is_action_released("jump") && parent.velocity.y < 0:
			parent.velocity.y = 0.0
	if state == states.fall:
		if event.is_action_pressed("jump"):
			if  !coyote_timer.is_stopped():
				_jump()
			else:
				ground_timer.start()

func _jump() -> void:
	if !parent.can_jump:
		return
	$Sounds/Jump.play()
	coyote_timer.stop()
	parent.velocity.y = -parent.jump_force

func _state_logic(delta: float) -> void:
	parent._handle_move_input()
	parent._apply_gravity(delta)
	parent._apply_movement()

func _get_transition(delta):
	match state:
		states.idle:
			if !parent.is_on_floor():
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y > 0:
					return states.fall
			elif parent.velocity.x != 0:
				return states.run
		states.run:
			if !parent.is_on_floor():
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y > 0:
					return states.fall
			elif parent.velocity.x == 0:
				return states.idle
		states.jump:
			if parent.is_on_floor():
				return states.idle
			elif parent.velocity.y >= 0:
				return states.fall
		states.fall:
			if parent.is_on_floor():
				return states.idle
			elif parent.velocity.y < 0:
				return states.jump
	return null

func _enter_state(new_state, old_state):
	match new_state:
		states.idle:
			animation_player.play("idle")
		states.run:
			animation_player.play("walk")
		states.jump:
			animation_player.play("jump_fly")
		states.fall:
			animation_player.play("jump_fly")
			if [states.run, states.idle].has(old_state):
				coyote_timer.start()

func _exit_state(old_state, new_state):
	match old_state:
		states.fall:
			if new_state == states.idle:
				if !ground_timer.is_stopped():
					_jump()

