extends KinematicBody
export var damage = 1

func _on_hit(area):
	self.queue_free()
