extends KinematicBody
export var damage = 1
export var speed = 2000
var KILL_TIME = 3
var timer = 0
var entity_speed := 0.0
var parent = null
	
func _physics_process(delta):
	var forward_direction = global_transform.basis.z.normalized()
	global_translate(forward_direction * (speed + entity_speed) * delta)
	
	timer += delta
	if timer >= KILL_TIME:
		queue_free()

func _on_hit(area):
	self.queue_free()


func _on_Area_body_entered(body):
	if !body in parent.get_children():
		print("e")
