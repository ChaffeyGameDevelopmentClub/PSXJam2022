extends Area

#missle assets : https://github.com/IndieQuest/GodogFightSimple

var shoot = false
var damage = 100
var speed = 200
var target = null


func _ready():
	set_as_toplevel(true)
	$Jet.emitting = true
	$LunchSound.play()
	
func _physics_process(delta):
	if shoot:
		if is_instance_valid(target) and target.visible:
			look_at(target.global_transform.origin, -Vector3.FORWARD)
		var forward_direction = -global_transform.basis.z.normalized()
		global_translate(forward_direction * speed * delta)

func _on_Missile_body_entered(body):
	var Ship_Stats = body as ShipEntity
	print("hit")
	if Ship_Stats:
		Ship_Stats.take_damage(damage)
		queue_free()
