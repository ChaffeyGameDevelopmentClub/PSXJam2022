extends Spatial


onready var blink_timer = $Timer
onready var warning = $PlayerInterface/Warning
onready var anomaly = $PlayerInterface/Anomaly


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(3), "timeout")
	anomaly.visible = true
	warning.visible = true
	blink_timer.start()
	yield(get_tree().create_timer(6), "timeout")
	anomaly.text = "EXITING \nKITTY SPACE"
	yield(get_tree().create_timer(6), "timeout")
	get_tree().change_scene_to(load("res://Assets/Scenes/Battle.tscn"))
	
	


var i = 0
func _process(delta):
	i += .1
	$Viewport/ColorRect.material.set_shader_param("iTime", i)


func _on_Timer_timeout():
	blink_timer.start()
	warning.visible = !warning.visible
