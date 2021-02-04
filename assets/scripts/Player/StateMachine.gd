class_name StateMachine
extends Node

export var initial_state := NodePath()

onready var state = get_node(initial_state)

func _ready() -> void:
	yield(owner, "ready")
	for child in get_children():
		child.state_machine = self
	state.enter()

func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)

func _process(delta: float) -> void:
	state.update(delta)

func _physics_process(delta: float) -> void:
	state.physics_update(delta)

func transition_to(state_name: String, msg := {}) -> void:
	if not has_node(state_name):
		return
	print("leave %s" % state.name)
	state.leave()
	state = get_node(state_name)
	print("enter %s" % state.name)
	state.enter(msg)
