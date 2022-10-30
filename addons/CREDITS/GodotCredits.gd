extends Control

export var bg_color : Color = Color.black
export var to_scene : PackedScene = null
export var title_color := Color.blueviolet
export var text_color := Color.white
export var title_font : DynamicFont = null
export var text_font : DynamicFont = null
export var Music : AudioStream = null
export var Use_Video_Audio : bool = false
export var Video : VideoStreamWebm = null
export var use_transitions : bool = false

const section_time := 2.0
const line_time := 0.3
const base_speed := 100
const speed_up_multiplier := 10.0

var scroll_speed : float = base_speed
var speed_up := false

onready var colorrect := $ColorRect
onready var videoplayer := $VideoPlayer
onready var line := $CreditsContainer/Line
var started := false
var finished := false

var section
var section_next := true
var section_timer := 0.0
var line_timer := 0.0
var curr_line := 1
var lines := []

var credits = [
	[
		"Developed by \nthe Chaffey Game Development Club",
		"Associated with Chaffey College"
	],[
		"Programming",
		"Kamran Haq",
		"Brandon Martin del Campo",
		"Jon Carmona"
	],[
		"Art",
		"Felix Strong",
		"Twitter: FelixLeaf, IG: @felix.forgor",
	],[
		"Modeling",
		"Felix Strong",
		"Twitter: FelixLeaf, IG: @felix.forgor",
		"Kira dela Cruz"
	],[
		"Title Screen Music",
		"Spectre XO",
		"IG: @spectrexoig"
	],
	[
		"Feedback and Suggestions",
		"Jessica Setiadhi",
		"Angela Ybarra",
		"Sean Castro Melendez",
		"@captainbrownie_chanchan",
		"David Reyes"
	],[
		"External",
		"Developed with Godot Engine",
		"https://godotengine.org/license",
		"",
		"Stock combat music by Victoria_paint from Pixabay",
		"Victoria_paint from Pixabay",
		"https://pixabay.com/id/music/drum-dan",
		"-bass-energy-of-the-morning-ambient-chillout-lounge-relaxing-music-7203/",
		"",
		"Shaders",
		"https://godotshaders.com/shader/procedural-hex-barrier-shader/",
		"/procedural-hex-barrier-shader/",
		"https://godotshaders.com/shader",
		"/procedural-electric-background-shader/",
		"https://godotshaders.com/shader/protean-clouds/",
		"",
		"Fonts",
		"https://www.dafont.com/nasalization.font",
		"https://www.dafont.com/hypik.font"
	],[
		"Special thanks to",
		"Dr. Tracy, the Advisor of the \nChaffey Game Development Club",
		"And",
		"Chaffey College"
	]
]

func _ready():
	colorrect.color = bg_color
	videoplayer.set_stream(Video)
	if use_transitions:
		$AnimationPlayer.play("Start")
	if !Use_Video_Audio:
		var stream = AudioStreamPlayer.new()
		stream.set_stream(Music)
		add_child(stream)
		videoplayer.set_volume_db(-80)
		stream.play()
	else:
		videoplayer.set_volume_db(0)
	videoplayer.play()
	

func _process(delta):
	scroll_speed = base_speed * delta
	
	if section_next:
		section_timer += delta * speed_up_multiplier if speed_up else delta
		if section_timer >= section_time:
			section_timer -= section_time
			
			if credits.size() > 0:
				started = true
				section = credits.pop_front()
				curr_line = 0
				add_line()
	
	else:
		line_timer += delta * speed_up_multiplier if speed_up else delta
		if line_timer >= line_time:
			line_timer -= line_time
			add_line()
	
	if speed_up:
		scroll_speed *= speed_up_multiplier
	
	if lines.size() > 0:
		for l in lines:
			l.rect_position.y -= scroll_speed
			if l.rect_position.y < -l.get_line_height():
				lines.erase(l)
				l.queue_free()
	elif started:
		finish()


func finish():
	if not finished:
		finished = true
		if use_transitions:
			$AnimationPlayer.play("Finish")
			yield($AnimationPlayer, "animation_finished")
		if to_scene != null:
			var path = to_scene.get_path()
			get_tree().change_scene(path)
		else:
			get_tree().quit()
		# NOTE: This is called when the credits finish
		# - Hook up your code to return to the relevant scene here, eg...
		#get_tree().change_scene("res://scenes/MainMenu.tscn")


func add_line():
	var new_line = line.duplicate()
	new_line.text = section.pop_front()
	lines.append(new_line)
	if curr_line == 0:
		if title_font != null:
			new_line.add_font_override("font", title_font)
		new_line.add_color_override("font_color", title_color)
	
	else:
		if text_font != null:
			new_line.add_font_override("font", text_font)
		new_line.add_color_override("font_color", text_color)
	
	$CreditsContainer.add_child(new_line)
	
	if section.size() > 0:
		curr_line += 1
		section_next = false
	else:
		section_next = true


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		finish()
	if event.is_action_pressed("ui_down") and !event.is_echo():
		speed_up = true
	if event.is_action_released("ui_down") and !event.is_echo():
		speed_up = false
