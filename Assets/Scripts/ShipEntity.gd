extends RigidBody

class_name ShipEntity


#export(PackedScene) var Star
onready var Star = preload("res://Assets/Scenes/Particle_On_Death.tscn")

onready var CenterOfMass = $CenterOfMass
onready var Heading = $Heading
onready var MainThruster = $MainThruster
onready var ShieldTimer = $ShieldTimer
onready var BoostTimer = $BoostTimer

export (float) var hull_integrity = 1 #Hull health
export (float) var shield_integrity = 1 #Shield health
export (float) var turn_handling = 1 #Affects turning rates
export (float) var move_handling = 1
var current_hull_integrity = 0
var current_shield_integrity = 0
export (bool) var flight_assist = true #Will never be false for AI
export (float) var thrust_strength = 1
export (float) var shield_regen_rate = 1
export (float) var shield_regen_cooldown_seconds = 0.5 #Seconds
var thrust_multiplier = 0
export (float) var ship_linear_damp = 2
export (float) var ship_angular_damp = 2
export (float) var boost_time = 0.5
export (float) var boost_strength = 20
export (float) var boost_cooldown_time = 4

var boosting = false
var boost_cooldown = false

# Called when the node enters the scene tree for the first time.
func _ready():
	current_hull_integrity = hull_integrity
	current_shield_integrity = shield_integrity
	ShieldTimer.wait_time = 0.5

func _physics_process(delta):
	if (flight_assist):
		linear_damp = ship_linear_damp
		angular_damp = ship_angular_damp
	else:
		linear_damp = 0
		angular_damp = 0
	
	if not boosting:
		add_force(self.transform.basis.z*thrust_strength*thrust_multiplier, Vector3.ZERO)
	else:
		add_force(self.transform.basis.z*boost_strength, Vector3.ZERO)
		

func take_damage(amount: float):
	print("Took damage")
	var temp = current_shield_integrity
	current_shield_integrity -= amount
	current_shield_integrity = clamp(current_shield_integrity, 0, shield_integrity)
	print(current_shield_integrity, "sheild")
	if current_shield_integrity <= 0:
		current_hull_integrity -= (amount - temp)
		Get_Destoryed()
		print(current_hull_integrity, "Hull")

#Takes a value from -1 to 1
func set_main_thruster(thrust_amount:float):
	thrust_amount = clamp(thrust_amount, -1, 1)
	thrust_multiplier = thrust_amount

func start_boost():
	if not boosting and not boost_cooldown:
		BoostTimer.wait_time = boost_time
		BoostTimer.start()
		boosting = true
	
func add_pitch(amount):
	add_torque(transform.basis.x*amount)
	
func add_yaw(amount):
	add_torque(transform.basis.y*amount)
	
func add_roll(amount):
	add_torque(transform.basis.z*amount)

func _on_BoostTimer_timeout():
	if boost_cooldown:
		boost_cooldown = false
		return
	boosting = false
	boost_cooldown = true
	BoostTimer.wait_time = boost_cooldown_time
	BoostTimer.start()
	
func _on_Hurtbox_area_entered(area):
  pass

func Get_Destoryed():
	var Death_Particles = Star.instance()
	Death_Particles.global_transform = CenterOfMass.global_transform
	var scene_root = get_tree().get_root().get_children()[0]
	scene_root.add_child(Death_Particles)
	queue_free()
	
	
