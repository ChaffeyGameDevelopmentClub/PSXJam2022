extends Spatial

export var speed = 100
var KILL_TIME = 3
var timer = 0
func _physics_process(delta):
	var forward_direction = global_transform.basis.z.normalized()
	global_translate(forward_direction * speed * delta)
	
	timer += delta
	if timer >= KILL_TIME:
		queue_free()
export var damage = 1


func _on_1_body_entered(body):#bullet1 on it code
	print("hit 1")
	$bullet1.queue_free()




func _on_2_body_entered(body):#bullet2 on it code
	print("hit 2 ")
	$bullet2.queue_free()

