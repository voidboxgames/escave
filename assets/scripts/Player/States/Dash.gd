extends PlayerState

onready var dash_timer: Timer = $DashTimer
onready var dash_sound: AudioStreamPlayer = $Dash

var previous_state: String

signal dashed

func enter(msg := {}) -> void:
	previous_state = msg.get("from", "Idle")
	emit_signal("dashed")
	Audio.rand_pitch_play(dash_sound)
	player.animations.play("air")
	dash_timer.start()

func leave() -> void:
	if not player.is_on_floor():
		player.current_dashes += 1
	player.velocity = Vector2.ZERO

func physics_update(_delta: float) -> void:
	player.velocity = player.last_direction.normalized() * player.current_max_speed * player.dash_multiplier
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)

func _on_DashTimer_timeout() -> void:
	state_machine.transition_to(previous_state)
