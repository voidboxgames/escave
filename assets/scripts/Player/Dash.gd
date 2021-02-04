extends PlayerState

onready var dash_timer: Timer = $DashTimer

var previous_state: String

func enter(msg := {}) -> void:
	previous_state = msg.get("from", "Idle")
	if not player.is_on_floor():
		player.current_dashes += 1
	player.animations.play("air")
	dash_timer.start()

func leave() -> void:
	player.velocity = Vector2.ZERO

func physics_update(delta: float) -> void:
	if dash_timer.is_stopped():
		state_machine.transition_to(previous_state)
		return

	player.velocity = player.last_direction.normalized() * player.current_max_speed * player.dash_multiplier
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)

