extends Node2D

@onready var player = $player

var time = -1
var time_to_transition = 2.0

var goal_color
var last_color

func _process(delta):
	if time >= 0:
		print('test')
		
		var t = time / time_to_transition
		
		t = ease_in_and_out(t)
		
		change_color(t)
		
		time += delta
		if time > time_to_transition:
			time = -1
			modulate = goal_color
			
			if modulate != Color(1, 1, 1, 1):
				set_color_to(Color(1, 1, 1, 1))

func set_color_to(new_color):
	goal_color = new_color
	last_color = modulate
	time = 0

func change_color(t: float):
	modulate = last_color * (1-t) + goal_color * t

func ease_in_and_out(x: float) -> float:
	x = (sin(PI * (x - .5)) + 1) / 2
	return x

func ease_in(x: float) -> float:
	x = sin((PI / 2) * (x - 1)) + 1
	return x

func ease_out(x: float) -> float:
	x = sin((PI / 2) * x)
	return x

func start_transition():
	pass

func load_next_scene(scene_path: String):
	print('load scene')
	set_color_to(Color(0, 0, 0, 1))



func _on_corridor_open_this_scene(scene_path):
	load_next_scene('cooli')
