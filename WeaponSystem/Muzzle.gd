extends Spatial

onready var homing_projectile = preload("res://WeaponSystem/HomingProjectile.tscn")
onready var muzzle_aim = $MuzzleAim

func _ready():
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("fire"):
		if muzzle_aim.is_colliding():
			print("is colliding")
			var projectile = homing_projectile.instance()
			add_child(projectile)
			projectile.look_at(muzzle_aim.get_collision_point(), Vector3.UP)
			projectile.shoot = true
