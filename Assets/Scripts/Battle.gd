extends Spatial
onready var enemy_spawn = $CatPlanet/EnemySpawn
onready var player = $Player
onready var enemy_one = preload("res://Assets/Scenes/CatEnemy1.tscn")
onready var enemy_two = preload("res://Assets/Scenes/CatEnemy2.tscn")

var phase_2 = false
var phase_3 = false
var phase_4 = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Battletrack.play(0)
	randomize()
	fade_in()
	for i in range(10):
		var new_enemy = enemy_two.instance()
		add_child(new_enemy)
		var offset = 1000
		new_enemy.global_translation = enemy_spawn.global_translation
		new_enemy.global_translation.x += rand_range(-offset, offset)
		new_enemy.global_translation.y += rand_range(-offset, offset)
		new_enemy.global_translation.z += rand_range(-offset, offset)
	player.start_message(10, "HOSTILES\nINBOUND")

func fade_in():
	var tween :=  get_tree().create_tween()
	tween.tween_property($Blindfold, "modulate:a", 0.0, 1)

func fade_out():
	var tween := get_tree().create_tween()
	tween.tween_property($Blindfold, "modulate:a", 1.0, 1)
	
func _process(delta):
	if not phase_2:
		var enemies = get_tree().get_nodes_in_group("enemy")
		if len(enemies) <= 0:
			print("e")
			phase_2 = true
			for i in range(10):
				var new_enemy = enemy_one.instance()
				add_child(new_enemy)
				var offset = 1000
				new_enemy.global_translation = enemy_spawn.global_translation
				new_enemy.global_translation.x += rand_range(-offset, offset)
				new_enemy.global_translation.y += rand_range(-offset, offset)
				new_enemy.global_translation.z += rand_range(-offset, offset)
	if phase_2 and not phase_3:
		var enemies = get_tree().get_nodes_in_group("enemy")
		if len(enemies) <= 0:
			phase_3 = true
			for i in range(5):
				var new_enemy = enemy_one.instance()
				add_child(new_enemy)
				var offset = 1000
				new_enemy.global_translation = enemy_spawn.global_translation
				new_enemy.global_translation.x += rand_range(-offset, offset)
				new_enemy.global_translation.y += rand_range(-offset, offset)
				new_enemy.global_translation.z += rand_range(-offset, offset)
			for i in range(5):
				var new_enemy = enemy_two.instance()
				add_child(new_enemy)
				var offset = 1000
				new_enemy.global_translation = enemy_spawn.global_translation
				new_enemy.global_translation.x += rand_range(-offset, offset)
				new_enemy.global_translation.y += rand_range(-offset, offset)
				new_enemy.global_translation.z += rand_range(-offset, offset)
	if phase_3 and not phase_4:
		var enemies = get_tree().get_nodes_in_group("enemy")
		if len(enemies) <= 0:
			$CatPlanet.start_boss_mode()
			print("boss mode")
			phase_4 = true
