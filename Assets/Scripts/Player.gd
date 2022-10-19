extends ShipEntity

func _on_Hurtbox_area_entered(area):
	var projectile = area.get_parent()
	if projectile.is_in_group("enemy"):
		take_damage(projectile.damage) 

func _input(event):
	if event is InputEventMouseMotion:
		var movement = event.relative
		rotation.x += deg2rad(movement.y * .2 )
		rotation.x = clamp(rotation.x, deg2rad(-90), deg2rad(90))
		rotation.y += -deg2rad(movement.x * .2)
		rotation.y = clamp(rotation.y, deg2rad(-180), deg2rad(180))
	
func _physics_process(delta):
	if Input.is_action_pressed("move_forward"):
			add_force(self.transform.basis.z*100, Vector3.ZERO)
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
func _ready():

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
