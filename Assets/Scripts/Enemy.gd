#https://godotengine.org/qa/92316/how-to-find-torque-to-rotate-object-towards-desired-rotation
extends ShipEntity

onready var player = get_tree().get_nodes_in_group("player")[0]
onready var torque_controller = $TorqueController
onready var meow_1 = $Meow1
onready var meow_2 = $Meow2


var state = SEEKING

enum {
	IDLE,
	SEEKING,
	FLEEING
}

func _ready():
	$Engine.play()
	set_main_thruster(0)

func _on_Hurtbox_area_entered(area):
	return
	var projectile = area.get_parent()
	if projectile.is_in_group("player_projectile"):
		take_damage(projectile.damage) 


func _physics_process(delta):
	
	#if rand_range(0, 100) == 50:
	if randi()%2+1 == 1:
		if meow_1.playing == false:
			meow_1.pitch_scale = rand_range(0.01, 4)
			meow_1.play()


	
	var player_dist = self.translation.distance_to(player.translation)
	if player_dist < 100:
		state = FLEEING
	elif (player_dist < 5000 + rand_range(-5000, 5000) and player_dist > 100 ):
		state = SEEKING

	match state:
		IDLE:
			set_main_thruster(0)
		SEEKING:
			set_main_thruster(1)
			var new_transform = transform.looking_at(player.translation, Vector3.UP)
			var rotating_vector = transform.basis.z.cross(new_transform.basis.z*turn_handling)
			var angle = rotating_vector.angle_to(rotation)
			$WeaponControls._shoot()
			#var multiplier = torque_controller.calculate(0, -angle)
			#multiplier = 1

			add_torque(-rotating_vector*40)

		FLEEING:
			set_main_thruster(1)
			var new_transform = transform.looking_at(player.translation, Vector3.UP)
			var rotating_vector = transform.basis.z.cross(new_transform.basis.z*turn_handling)
			var angle = rotating_vector.angle_to(rotation)
			#print(angle)
			#var multiplier = torque_controller.calculate(0, angle)
			#multiplier = 1

			add_torque(rotating_vector*40)
