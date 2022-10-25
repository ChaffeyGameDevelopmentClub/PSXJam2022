extends Node2D

onready var quit = $Quit_Button/quitbox
onready var credits = $Credits_Button/creditsbox
onready var start = $Start_Button/startbox

var default_color = Color("ee00ff")

func _on_Quit_Button_pressed():
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
