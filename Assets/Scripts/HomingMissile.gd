extends Area

#missle assets : https://github.com/IndieQuest/GodogFightSimple

var damage = 100
var speed = 200
var shoot = false
var target = null
var target_visible = null
var enemy = null


func _ready():
	set_as_toplevel(true)
	$Jet.emitting = true
	#$LunchSound.play()
	if target.visible:
		target_visible = true
	
func _physics_process(delta):
	var forward_direction = global_transform.basis.z.normalized()
	if shoot and is_instance_valid(enemy) and target_visible:
			forward_direction = -global_transform.basis.z.normalized()
			look_at(enemy.global_transform.origin, Vector3.UP)
	global_translate(forward_direction * speed * delta)

func _on_Missile_body_entered(body):
	var Ship_Stats = body as ShipEntity
	print("hit")
	if Ship_Stats:
		Ship_Stats.take_damage(damage)
		queue_free()
