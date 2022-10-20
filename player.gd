extends RigidBody



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
export (float) var boost_strength = 200

var sen = 0.01


var boosting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	current_hull_integrity = hull_integrity
	current_shield_integrity = shield_integrity
	ShieldTimer.wait_time = 0.5
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	if (flight_assist):
		linear_damp = ship_linear_damp
		angular_damp = ship_angular_damp
	else:
		linear_damp = 0
		angular_damp = 0
	if Input.is_action_pressed("W"):
			add_force(self.transform.basis.z*100, Vector3.ZERO)
	
	if not boosting:
		add_force(self.transform.basis.z*thrust_strength*thrust_multiplier, Vector3.ZERO)
	else:
		add_force(self.transform.basis.z*boost_strength, Vector3.ZERO)
	if Input.is_action_just_pressed("Q"):
		get_tree().quit()
		

#Takes a value from -1 to 1
func set_main_thruster(thrust_amount:float):
	thrust_amount = clamp(thrust_amount, -1, 1)
	thrust_multiplier = thrust_amount

func start_boost():
	BoostTimer.wait_time = boost_time
	BoostTimer.start()
	boosting = true

func _on_BoostTimer_timeout():
	boosting = false

func _input(event):
	if event is InputEventMouseMotion:
		var movement = event.relative
		rotation.x += deg2rad(movement.y * .02 )
		rotation.x = clamp(rotation.x, deg2rad(-90), deg2rad(90))
		rotation.y += -deg2rad(movement.x * .02)
		

