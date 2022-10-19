extends ShipEntity

onready var player = get_tree().get_nodes_in_group("player")[0]
onready var pitch_controller = $PitchController
onready var yaw_controller = $YawController
onready var roll_controller = $RollController
var target_x = 0
var target_y = 0
var target_z = 0

func _ready():
	set_main_thruster(1)

func _on_Hurtbox_area_entered(area):
	var projectile = area.get_parent()
	if projectile.is_in_group("player"):
		take_damage(projectile.damage) 


	
func _physics_process(delta):
	var angle = self.global_translation.direction_to(player.global_translation)
	print(angle)
	var target = self.translation.direction_to(player.translation)
	#print(target.x)
	target_x = -target.x
	target_y = target.y
	#print(target)
	add_torque(Vector3.LEFT*-pitch_controller.calculate(0, self.rotation.x))
	print(rotation.x)
	#add_pitch(pitch_controller.calculate(target_x, self.rotation.x))
	#add_yaw(yaw_controller.calculate(target_y, self.rotation.y))
	#print(diff)
	#print(rotation.x, " " ,rotation.y)


	
	#add_roll(roll_controller.calculate(target.z, self.rotation.z))
	

	
	
