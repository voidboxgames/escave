extends CanvasLayer

var done: Dictionary
var monologues: Dictionary = {
	"intro": "How did I end up in here? Everone in this world is against me. I barely want use 'A' and 'D' to move my legs.",
	"no_jump": "My heart feels so heavy.. i can't even [wave]jump[/wave]",
	"can_jump": "get yourself together! you must try to [rainbow]jump[/rainbow] with 'J'",
	"can_dash": "i can do it! i can dash [rainbow]dash[/rainbow] with 'K'!",
	"can_ddash": "can i.. can i even [rainbow]double dash[/rainbow]?",
	"can_walk_fast": "my heart feels [rainbow]lighter[/rainbow] now!",

	"bottomless": "I'm slowly sinking into a [rainbow]bottomless[/rainbow] pit",
	"go_on": "why should i even [rainbow]go on[/rainbow]?",
	"the_fall": "it is too deep, i can't make it",
	"agony": "there is just more [rainbow]agony[/rainbow] to come, i should give up...",
}

func visible(val: bool) -> void:
	$TextureRect.visible = val

func _ready() -> void:
	visible(false)
	pause_mode = PAUSE_MODE_PROCESS

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_SPACE):
		get_tree().paused = false
		$TextureRect/Label.bbcode_text = ""
		visible(false)

func play(monolog: String) -> void:
	if !done.has(monolog):
		get_tree().paused = true
		$TextureRect/Label.bbcode_text = "[center]"+monologues[monolog]
		done[monolog] = true
		visible(true)
