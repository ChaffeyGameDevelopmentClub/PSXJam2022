extends Spatial

onready var RateOfFire_timer = $Timer3
onready var Reload_Timer = $Timer4
onready var Homing_Missile = preload("res://WeaponSystem/Missile/HomingMissile.tscn")
var can_shoot = true
var Is_Reloading = false
var Missiles_shot = 0
var Max_Missiles = 50

export var muzzle_speed = 20
export var Seconds_Between_Shoots = .14
export var Reload_Time = 3

func _ready():
	#RateOfFire_timer.wait_time = Seconds_Between_Shoots /1.0
	Reload_Timer.wait_time = Reload_Time
	pass


func _process(delta):
	pass
	
func _secondary_shoot():
	if !Is_Reloading:
		if can_shoot:
			var New_Homing_Missile = Homing_Missile.instance()
			New_Homing_Missile.global_transform =$Spawn_location_Missile.global_transform
			#New_Homing_Missile.speed = muzzle_speed
			var scene_root = get_tree().get_root().get_children()[0]
			scene_root.add_child(New_Homing_Missile)
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

