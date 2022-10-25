extends Spatial

# Called when the node enters the scene tree for the first time.
func _ready():
	fade_in()

func fade_in():
	var tween :=  get_tree().create_tween()
	tween.tween_property($Blindfold, "modulate:a", 0.0, 1)

func fade_out():
	var tween :=  get_tree().create_tween()
	tween.tween_property($Blindfold, "modulate:a", 1.0, 1)
