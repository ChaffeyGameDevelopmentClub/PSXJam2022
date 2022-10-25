#https://godotengine.org/qa/92316/how-to-find-torque-to-rotate-object-towards-desired-rotation
extends ShipEntity

onready var player = get_tree().get_nodes_in_group("player")[0]
onready var torque_controller = $TorqueController


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
	var player_dist = self.translation.distance_to(player.translation)
	if player_dist < 300:
		state = FLEEING
	elif (player_dist < 700 and player_dist > 300 ):
		state = SEEKING

	
	#if self.translation.distance_to(player.translation) >= 1000:
		#state = IDLE

	match state:
		IDLE:
			set_main_thruster(0)
		SEEKING:
			set_main_thruster(1)
			var new_transform = transform.looking_at(player.translation, Vector3.UP)
			var rotating_vector = transform.basis.z.cross(new_transform.basis.z)
			var angle = rotating_vector.angle_to(rotation)
			var multiplier = torque_controller.calculate(0, -angle)
			multiplier = 1

			add_torque(-rotating_vector*multiplier*40)

		FLEEING:
			set_main_thruster(1)
			var new_transform = transform.looking_at(player.translation, Vector3.UP)
			var rotating_vector = transform.basis.z.cross(new_transform.basis.z)
			var angle = rotating_vector.angle_to(rotation)
			#print(angle)
			var multiplier = torque_controller.calculate(0, angle)
			multiplier = 1

			add_torque(rotating_vector*multiplier*40)
		

