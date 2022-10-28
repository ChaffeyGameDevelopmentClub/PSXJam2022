extends Spatial

export var speed = 2000
var KILL_TIME = 15
var timer = 0
var Damage = 5
var entity_speed := 0.0
	
func _physics_process(delta):
	var forward_direction = global_transform.basis.z.normalized()
	global_translate(forward_direction * (speed + entity_speed) * delta)
	
	timer += delta
	if timer >= KILL_TIME:
		queue_free()

func _on_1_body_entered(body:Node):#bullet's code
	print("hit 1")
	
	if body is ShipEntity:
		var Ship_Stats = body as ShipEntity
		Ship_Stats.take_damage(Damage)
	$bullet1.queue_free()

func _on_2_body_entered(body:Node):#bullet2's code
	print("hit 2 ")

	if body is ShipEntity:
		var Ship_Stats = body as ShipEntity
		
		Ship_Stats.take_damage(Damage)
	$bullet2.queue_free()

