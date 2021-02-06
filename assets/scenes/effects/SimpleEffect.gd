extends Node2D

signal done

func destroy() -> void:
	queue_free()
	emit_signal("done")
