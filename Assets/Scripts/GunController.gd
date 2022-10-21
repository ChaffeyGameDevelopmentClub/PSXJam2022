extends Node



onready var RateOfFire_timer = $Timer
var can_shoot = true

export(PackedScene) var Bullet
export var muzzle_speed = 20
export var Seconds_Between_Shoots = .1
func _ready():
	RateOfFire_timer.wait_time = Seconds_Between_Shoots /1.0
	pass


func _process(delta):
	pass
	
func _shoot():
		if can_shoot:
			var New_bullet = Bullet.instance()
			New_bullet.global_transform =$Spawn_location_Bullet.global_transform
			#New_bullet.speed = muzzle_speed
			var scene_root = get_tree().get_root().get_children()[0]
			scene_root.add_child(New_bullet)
			can_shoot = false
			RateOfFire_timer.start()
		
		
	


func _on_Timer_timeout():
	can_shoot = true
