extends RigidBody

class_name ShipEntity

onready var CenterOfMass = $CenterOfMass
onready var Heading = $Heading
onready var MainThruster = $MainThruster
onready var ShieldTimer = $ShieldTimer

export (float) var hull_integrity = 1 #Hull health
export (float) var shield_integrity = 1 #Shield health
export (float) var turn_handling = 1 #Affects turning rates
export (float) var move_handling = 1
var current_hull_integrity = 0
var current_shield_integrity = 0
export (bool) var axis_lock = true #Will never be false for AI
export (bool) var flight_assist = true #Will never be false for AI
export (float) var thrust_strength = 1
export (float) var shield_regen_rate = 1
export (float) var shield_regen_cooldown_seconds = 0.5 #Seconds
var thrust_multiplier = 0
export (float) var ship_linear_damp = 2
export (float) var ship_angular_damp = 2

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
	
	add_force(Vector3.BACK*thrust_strength*thrust_multiplier, Vector3.ZERO)
	if Input.is_action_just_pressed("ui_down"):
		start_boost()
	
#Takes a value from -1 to 1
func set_main_thruster(thrust_amount:float):
	thrust_amount = clamp(thrust_amount, -1, 1)
	thrust_multiplier = thrust_amount

func start_boost():
	add_force(Vector3.BACK*1000, Vector3.ZERO)