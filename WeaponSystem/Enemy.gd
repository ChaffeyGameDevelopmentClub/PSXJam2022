extends KinematicBody

export var health = 200

func _ready():
	pass

func _physics_process(delta):
	if health <= 0:
		queue_free()
	#if Input.is_action_pressed("move_left"):
	#	self.translation.x += 10 * delta	
	#elif Input.is_action_pressed("move_right"):
	#	self.translation.x -= 10 * delta
	#elif Input.is_action_pressed("move_forward"):
	#	self.translation.y += 10 * delta
	#elif Input.is_action_pressed("move_backward"):
	#	self.translation.y -= 10 * delta
	#else:
	#	self.translation.x -= 10 * delta
func on_body_entered(body:Node):#bullet's code
	print("hit 1")
	
	var Ship_Stats = body as ShipEntity
	Ship_Stats.take_damage(50)
	$bullet1.queue_free()
