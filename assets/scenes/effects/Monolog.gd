extends CanvasLayer

var done: Dictionary

func play(monolog: String) -> void:
	if !done.has(monolog):
		$Animations.play(monolog)
		done[monolog] = true
