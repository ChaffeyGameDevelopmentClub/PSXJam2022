extends Area

#missle assets : https://github.com/IndieQuest/GodogFightSimple

var shoot = false
var damage = 50
var speed = 20
var target = null

func _ready():
	set_as_toplevel(true)
	$Jet.emitting = true
	$LunchSound.play()
	
func _physics_process(delta):
	if shoot && is_instance_valid(target):
		look_at(target.global_transform.origin, -Vector3.FORWARD)
	translate(Vector3(0,0,-1) * speed * delta)

func _on_Missile_body_entered(body):
	print('test')
	if body.is_in_group("Enemy"):
		body.health -= damage
		print('Enemy hit!')
		queue_free()
	else:
		queue_free()
