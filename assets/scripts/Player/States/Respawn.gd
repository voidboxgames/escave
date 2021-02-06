extends PlayerState

onready var respawn_sound = $Death

func enter(_msg := {}) -> void:
	Audio.rand_pitch_play(respawn_sound)
	player.animations.play("dead")

func respawn() -> void:
	state_machine.transition_to("Air")
