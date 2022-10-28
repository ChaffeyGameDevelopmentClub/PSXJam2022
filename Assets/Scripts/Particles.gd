extends Spatial

onready var explosion = $explosion
onready var particles = $Particles

func _ready():
	particles.one_shot = true
	explosion.play()
