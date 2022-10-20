extends ShipEntity

func _on_Hurtbox_area_entered(area):
	var projectile = area.get_parent()
	if projectile.is_in_group("enemy"):
		#take_damage(projectile.damage) 
		pass

func _input(event):
	if event is InputEventMouseMotion:
		var movement = event.relative
		add_yaw(-deg2rad(movement.x * 2.3))
		add_pitch(deg2rad(movement.y * 2.3 ))
		
		#rotation.x += deg2rad(movement.y * .2 )
		#rotation.x = clamp(rotation.x, deg2rad(-90), deg2rad(90))
		#rotation.y += 
		#rotation.y = clamp(rotation.y, deg2rad(-180), deg2rad(180))
	
func _physics_process(delta):
	
	if Input.is_action_pressed("roll_left"):
		add_roll(-1)
	if Input.is_action_pressed("roll_right"):
		add_roll(1)
		
	if Input.is_action_pressed("move_forward"):
			set_main_thruster(1)
	elif Input.is_action_pressed("move_backward"):
		set_main_thruster(-0.5)
	else:
		set_main_thruster(0)
		
	if Input.is_action_pressed("ui_up"):
		add_central_force(self.transform.basis.y)
	elif Input.is_action_pressed("ui_down"):
		add_central_force(-self.transform.basis.y)
		
	if Input.is_action_pressed("ui_right"):
		add_central_force(-self.transform.basis.x)
	elif Input.is_action_pressed("ui_left"):
		add_central_force(self.transform.basis.x)

	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
func _ready():

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
