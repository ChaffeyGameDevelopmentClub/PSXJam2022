extends Node



onready var RateOfFire_timer = $Timer
onready var Reload_Timer = $Timer2
var can_shoot = true
var Is_Reloading = false
var Bullets_shot = 0
var Max_Bullet = 50
var current_group = ""
signal fire

export(PackedScene) var Bullet
export var muzzle_speed = 20
export var Seconds_Between_Shoots = .14
export var Reload_Time = 2
func _ready():
	RateOfFire_timer.wait_time = Seconds_Between_Shoots /1.0
	Reload_Timer.wait_time = Reload_Time
	pass


func _process(delta):
	pass
	
func _shoot():
	if !Is_Reloading:
		if can_shoot:
			emit_signal("fire")
			var New_bullet = Bullet.instance()
			New_bullet.add_to_group("player_projectile")
			New_bullet.entity_speed = (get_parent().linear_velocity.length())
		
			New_bullet.global_transform = $Spawn_location_Bullet.global_transform
			#New_bullet.speed = muzzle_speed
			var scene_root = get_tree().get_root().get_children()[0]
			scene_root.add_child(New_bullet)
			Bullets_shot +=1
			
			if Bullets_shot >= Max_Bullet:
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
	Bullets_shot = 0
	Is_Reloading = false
	can_shoot = true
