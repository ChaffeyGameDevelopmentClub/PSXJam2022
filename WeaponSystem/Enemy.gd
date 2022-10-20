extends KinematicBody

export var health = 200

func _ready():
	pass

func _physics_process(delta):
	if health <= 0:
		queue_free()
	if Input.is_action_pressed("move_left"):
		self.translation.x += 10 * delta	
	elif Input.is_action_pressed("move_right"):
		self.translation.x -= 10 * delta
	elif Input.is_action_pressed("move_forward"):
		self.translation.y += 10 * delta
	elif Input.is_action_pressed("move_backward"):
		self.translation.y -= 10 * delta
	else:
		self.translation.x -= 10 * delta
