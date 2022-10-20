extends ShipEntity

onready var player = get_tree().get_nodes_in_group("player")[0]
onready var x_controller = $XController
onready var y_controller = $YController
onready var z_controller = $ZController

var state = SEEKING

enum {
	IDLE,
	SEEKING,
	FLEEING
}

func _ready():
	set_main_thruster(0)

func _on_Hurtbox_area_entered(area):
	var projectile = area.get_parent()
	if projectile.is_in_group("player"):
		#take_damage(projectile.damage) 
		pass


	
func _physics_process(delta):
#	var player_dist = self.translation.distance_to(player.translation)
	#if player_dist < 50:
#		state = FLEEING
#	elif (player_dist < 2000 and player_dist > 300 ):
	#	state = SEEKING

	
	#if self.translation.distance_to(player.translation) >= 1000:
		#state = IDLE

	match state:
		IDLE:
			set_main_thruster(0)
		SEEKING:
			set_main_thruster(1)
			var v1 = Vector2(self.translation.x, self.translation.z)
			var v2 = Vector2(player.translation.x, player.translation.z)
			var v3 = (v1 - v2).angle()
			v3 += PI/2
			var target_y = v3
			
			
			
			v1 = Vector2(self.translation.y, self.translation.z)
			v2 = Vector2(player.translation.y, player.translation.z)
			v3 = (v1 - v2).angle()
			v3 += PI/2
			var target_x = v3
		
			add_torque(y_controller.calculate(-target_y, rotation.y)*Vector3.UP)
			add_torque(x_controller.calculate(target_x, rotation.x)*Vector3.RIGHT)
			#add_roll(z_controller.calculate(0, rotation.z))
	
		FLEEING:
			set_main_thruster(1)
			var v1 = Vector2(self.translation.x, self.translation.z)
			var v2 = Vector2(player.translation.x, player.translation.z)
			var v3 = (v1 - v2).angle()
			v3 += PI/2
			
			#add_yaw(yaw_controller.calculate(v3, rotation.y))
			
			v1 = Vector2(self.translation.y, self.translation.z)
			v2 = Vector2(player.translation.y, player.translation.z)
			v3 = (v1 - v2).angle()
			v3 += PI/2
			
			#add_pitch(pitch_controller.calculate(-v3, rotation.x))
			#add_roll(roll_controller.calculate(0, self.rotation.z))
