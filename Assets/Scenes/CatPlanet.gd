extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var boss_mode = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start_boss_mode():
	$eye1.visible = true
	$eye2.visible = true
	$mouth.visible = true
	boss_mode = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if boss_mode:
		pass
