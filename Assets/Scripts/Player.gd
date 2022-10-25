extends ShipEntity

onready var WeaponControls = $WeaponControls
onready var Spawn_location_Missile = $WeaponControls/Spawn_location_Missile
onready var thrust_bar = $PlayerInterface/ThrustBar
onready var shield = $Shield
var current_thrust_setting: float = 0
onready var warning_timer = $WarningTimer
onready var warning = $PlayerInterface/Warning
onready var camera = $Camera
onready var target = $PlayerInterface/Target
var current_enemy_index = 0

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

func _on_Timer_timeout():
	warning_timer.start()
	warning.visible = !warning.visible
	
#When a missile is locked
func start_warning():
	warning_timer.start()

func stop_warning():
	warning_timer.stop()
	warning.visible = false

func _physics_process(delta):
		
	var enemies =  get_tree().get_nodes_in_group("enemy")
	
	if Input.is_action_just_pressed("cycle_target"):
		current_enemy_index += 1
		if current_enemy_index >= len(enemies):
			current_enemy_index = 0
	
	var enemy_pos = enemies[current_enemy_index].translation
	if !camera.is_position_behind(enemies[current_enemy_index].translation):
		target.visible = true
		target.rect_position = camera.unproject_position(enemy_pos)
	else:
		target.visible = false
	
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
		add_roll(-turn_handling*delta)
	if Input.is_action_pressed("roll_right"):
		add_roll(turn_handling*delta)
		
	if Input.is_action_pressed("move_forward"):
		current_thrust_setting += 1
	elif Input.is_action_pressed("move_backward"):
		current_thrust_setting -= 1
		add_central_force(-self.transform.basis.z*move_handling)
	
	current_thrust_setting = clamp(current_thrust_setting, 0, 100)
	set_main_thruster(current_thrust_setting/100.0)
	thrust_bar.value = current_thrust_setting
	
		
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

