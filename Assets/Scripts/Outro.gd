extends Spatial


onready var blink_timer = $Timer
onready var warning = $PlayerInterface/Warning
onready var anomaly = $PlayerInterface/Anomaly


# Called when the node enters the scene tree for the first time.
func _ready():
	$hyper.play()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	fade_in()
	yield(get_tree().create_timer(1), "timeout")
	anomaly.visible = true
	anomaly.text = "YOU\nESCAPED"
	#warning.visible = true
	#$alarm.play()
	#blink_timer.start()
	yield(get_tree().create_timer(6), "timeout")
	#anomaly.text = "EXITING \nKITTY SPACE"
	#yield(get_tree().create_timer(6), "timeout")
	fade_out()
	yield(get_tree().create_timer(1.0), "timeout")
	get_tree().change_scene_to(load("res://Assets/Scenes/MainMenu.tscn"))
	

var i = 0
func _process(delta):
	i += .1
	$Viewport/ColorRect.material.set_shader_param("iTime", i)

func _on_Timer_timeout():
	blink_timer.start()
	warning.visible = !warning.visible
	if warning.visible:
		$alarm.play()

func fade_in():
	var tween :=  get_tree().create_tween()
	tween.tween_property($Blindfold, "modulate:a", 0.0, 1)

func fade_out():
	var tween :=  get_tree().create_tween()
	tween.tween_property($Blindfold, "modulate:a", 1.0, 1)
