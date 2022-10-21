extends Spatial

export var speed = 200
var KILL_TIME = 2
var timer = 0
func _physics_process(delta):
	var forward_direction = global_transform.basis.z.normalized()
	global_translate(forward_direction * speed * delta)
	
	timer += delta
	if timer >= KILL_TIME:
		queue_free()
export var damage = 1



#Work in progess
func _on_hit(area):
	self.queue_free()
