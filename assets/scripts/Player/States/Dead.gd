extends PlayerState

onready var death_sound = $Death

func enter(_msg := {}) -> void:
	Audio.rand_pitch_play(death_sound)
	player.animations.play("dead")

func respawn() -> void:
	state_machine.transition_to("Respawn")
