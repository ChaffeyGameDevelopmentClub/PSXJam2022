extends Spatial

onready var RateOfFire_timer = $Timer
onready var Reload_Timer = $Timer2
onready var Homing_Missile = preload("res://Assets/Scenes/HomingMissile.tscn")
var can_shoot = true
var Is_Reloading = false
var Missiles_shot = 0
var Max_Missiles = 50

export var muzzle_speed = 20
export var Seconds_Between_Shoots = .14
export var Reload_Time = 3

func _ready():
	RateOfFire_timer.wait_time = Seconds_Between_Shoots /1.0
	Reload_Timer.wait_time = Reload_Time
	pass


func _process(delta):
	pass
	
func _secondary_shoot(enemy, target):
	if !Is_Reloading:
		if can_shoot:
			var New_Homing_Missile = Homing_Missile.instance()
			New_Homing_Missile.transform = transform
			New_Homing_Missile.enemy = enemy
			New_Homing_Missile.target = target
			New_Homing_Missile.shoot = true
			add_child(New_Homing_Missile)
			Missiles_shot +=1
			
			if Missiles_shot >= Max_Missiles:
				can_shoot = false
				Reloading()
			elif can_shoot:
				can_shoot = false
				RateOfFire_timer.start()
			

func _on_Timer_timeout(): #Rate of fire timer
	can_shoot = true
	
func Reloading():
		Is_Reloading = true
		if Is_Reloading:
			can_shoot = false
			print("Is reloading")
			Reload_Timer.start()
		

func _on_Timer2_timeout():	#Reload timer
	print("Finished Reloading ")
	Is_Reloading = false
	Missiles_shot = 0
	Is_Reloading = false
	can_shoot = true	

