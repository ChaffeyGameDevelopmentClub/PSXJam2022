extends ShipEntity

onready var WeaponControls = $WeaponControls
onready var Spawn_location_Missile = $WeaponControls/Spawn_location_Missile

func _on_Hurtbox_area_entered(area):
	var projectile = area.get_parent()
	if projectile.is_in_group("enemy"):
		#take_damage(projectile.damage) 
		pass

func _input(event):
	if event is InputEventMouseMotion:
		var movement = event.relative
		add_yaw(-deg2rad(movement.x * turn_handling))
		add_pitch(deg2rad(movement.y * turn_handling))

	
func _physics_process(delta):
	
	#Shooting 
	
	
	if Input.is_action_pressed("fire"):
		WeaponControls._shoot()
	
	if Input.is_action_pressed("secondary_fire"):
		$WeaponControls/Spawn_location_Missile._secondary_shoot()
		
	#movement
	if Input.is_action_just_pressed("toggle_assist"):
		flight_assist = !flight_assist
	
	if Input.is_action_just_pressed("boost"):
		start_boost()
	
	if Input.is_action_pressed("roll_left"):
		add_roll(-turn_handling)
	if Input.is_action_pressed("roll_right"):
		add_roll(turn_handling)
		
	if Input.is_action_pressed("move_forward"):
			set_main_thruster(1)
	elif Input.is_action_pressed("move_backward"):
		set_main_thruster(-0.5)
	else:
		set_main_thruster(0)
		
	if Input.is_action_pressed("ui_up"):
		add_central_force(self.transform.basis.y*move_handling)
	elif Input.is_action_pressed("ui_down"):
		add_central_force(-self.transform.basis.y*move_handling)
		
	if Input.is_action_pressed("ui_right"):
		add_central_force(-self.transform.basis.x*move_handling)
	elif Input.is_action_pressed("ui_left"):
		add_central_force(self.transform.basis.x*move_handling)

	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
func _ready():

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
