extends ShipEntity

onready var WeaponControls = $WeaponControls
onready var thrust_bar = $PlayerInterface/ThrustBar
onready var shield = $Shield
var current_thrust_setting: float = 0
onready var warning_timer = $WarningTimer
onready var warning = $PlayerInterface/Warning
onready var camera = $Camera
onready var target = $PlayerInterface/Target
onready var health_bar = $PlayerInterface/Health
onready var shield_bar = $PlayerInterface/Shield
onready var engine_sound = $engine_sound
onready var shoot_sound = $shoot_sound
var current_enemy_index = 0

func  Get_Destroyed():
	pass

func _on_Hurtbox_area_entered(area):
	return
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
	if $PlayerInterface/Message.visible == true:
		$PlayerInterface/WarningMessage.visible = !$PlayerInterface/WarningMessage.visible
	else:
		warning.visible = !warning.visible
	
#When a missile is locked
func start_warning():
	warning_timer.start()

func stop_warning():
	warning_timer.stop()
	warning.visible = false

func start_message(time, message):
	$PlayerInterface/Message.text = message
	$PlayerInterface/Message.visible = true
	$PlayerInterface/WarningMessage.visible = true
	start_warning()
	yield(get_tree().create_timer(time), "timeout")
	stop_warning()
	$PlayerInterface/Message.visible = false
	$PlayerInterface/WarningMessage.visible = false

var last_enemy_count = 0
func _physics_process(delta):
	engine_sound.unit_db = current_thrust_setting - 50
	engine_sound.unit_db = clamp(engine_sound.unit_db, current_thrust_setting - 70, 0)
	engine_sound.pitch_scale = (current_thrust_setting/400) + 0.001
	
	health_bar.value = current_hull_integrity
	shield_bar.value = current_shield_integrity
	var enemies =  get_tree().get_nodes_in_group("enemy")
	
	if last_enemy_count != len(enemies):
		current_enemy_index = 0
	if Input.is_action_just_pressed("cycle_target"):
		current_enemy_index += 1
		if current_enemy_index >= len(enemies):
			current_enemy_index = 0
	if len(enemies) > 0:
		var enemy_pos = enemies[current_enemy_index].translation
		if !camera.is_position_behind(enemies[current_enemy_index].translation):
			target.visible = true
			target.rect_position = camera.unproject_position(enemy_pos)
		else:
			target.visible = false
	else:
		target.visible = false
		
	last_enemy_count = len(enemies)
	
	#Shooting 
	if Input.is_action_pressed("fire"):
		WeaponControls._shoot()
		
	
	if Input.is_action_pressed("secondary_fire"):
		if enemies:
			var enemy = enemies[current_enemy_index]
			WeaponControls.get_node("HomingWeapon")._secondary_shoot(enemy, target)

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
	engine_sound.play()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	WeaponControls.current_group = "player"

func _on_WeaponControls_fire():
	shoot_sound.play()

