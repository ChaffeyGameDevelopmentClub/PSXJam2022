extends Area

var shoot = false
var damage = 50
var speed = 20
var target = null

func _ready():
	set_as_toplevel(true)
	
func _physics_process(delta):
	if shoot && is_instance_valid(target):
		#self.look_at(transform.origin + velocity, Vector3.UP)
		#var velocity = (target.global_transform.origin - transform.origin)
		look_at(target.global_transform.origin, -Vector3.FORWARD)
	translate(Vector3(0,0,-1) * speed * delta)
		
	
func _on_Area_body_entered(body):
	if body.is_in_group("Enemy"):
		body.health -= damage
		print('Enemy hit!')
	else:
		#queue_free()
		pass
