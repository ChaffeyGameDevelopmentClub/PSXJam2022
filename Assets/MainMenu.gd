extends Control

onready var quit = $Control2/Quit_Button/quitbox
onready var credits = $Control2/Credits_Button/creditsbox
onready var start = $Control2/Start_Button/startbox
onready var opening = preload("res://Assets/Scenes/Opening.tscn")
onready var blindfold = $Blindfold

var default_color = Color("ee00ff")

func _ready():
	Input.MOUSE_MODE_VISIBLE
	$music.play()

func _on_Quit_Button_pressed():
	$select.play()
	get_tree().quit()

func _on_Quit_Button_mouse_entered():
	quit.color = Color.pink

func _on_Quit_Button_mouse_exited():
	quit.color = default_color

func _on_Credits_Button_mouse_entered():
	credits.color = Color.pink

func _on_Credits_Button_mouse_exited():
	credits.color = default_color

func _on_Start_Button_mouse_entered():
	start.color = Color.pink

func _on_Start_Button_mouse_exited():
	start.color =  default_color


func _on_Start_Button_pressed():
	$select.play()
	var tween :=  get_tree().create_tween()
	tween.tween_property(blindfold, "modulate:a", 1.0, 2)
	tween.tween_callback(self, "load_next_scene")



func _on_Credits_Button_pressed():
	$select.play()
	get_tree().change_scene("res://addons/CREDITS/GodotCredits.tscn")

func load_next_scene():
	get_tree().change_scene_to(opening)
