extends Control

onready var quit = $Control2/Quit_Button/quitbox
onready var start = $Control2/Start_Button/startbox

onready var mainMeun = preload("res://Assets/Scenes/MainMenu.tscn")


var default_color = Color("ee00ff")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func _on_Quit_Button_pressed():
	get_tree().quit()


func _on_Start_Button_pressed():
	get_tree().change_scene_to(mainMeun)


func _on_Start_Button_mouse_entered():
	start.color = Color.pink

func _on_Start_Button_mouse_exited():
	start.color =  default_color

func _on_Quit_Button_mouse_entered():
	quit.color = Color.pink

func _on_Quit_Button_mouse_exited():
	quit.color = default_color

