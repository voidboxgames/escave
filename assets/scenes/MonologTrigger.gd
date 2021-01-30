extends Area2D

export(String) var MonologID
export(NodePath) var MonologuePath
onready var monologue = get_node(MonologuePath)

func _on_MonologTrigger_body_entered(body: Node) -> void:
	if body is Player:
		monologue.play(MonologID)
