extends Node2D

@onready var player = $player #da wird der spieler gespeichert um von wo anders drauf zu zugreifen

var time = -1
var time_to_transition = 2.0

var goal_color
var last_color

func _process(delta): #wird jeden frame gecalled, delta ist die zeit seit dem letzten frame, meistesn 1/60, kann aber bei framdrops sich ändern
	if time >= 0:
		var t = time / time_to_transition #dadurch krieg ich zahlen zwischen 0 und 1 (bspw 0.345)
		
		t = ease_in_and_out(t) #sinus function, dadurch wird t "weicher" insbesondere bei bewegung hilfreich, kann man hier eigentlich weglassen
		
		change_color(t)
		
		time += delta
		if time > time_to_transition:
			time = -1
			modulate = goal_color

func set_color_to(new_color): #startet den timer und setzt neue zielfarben
	goal_color = new_color
	last_color = modulate
	time = 0

func change_color(t: float):
	modulate = last_color * (1-t) + goal_color * t #wenn t == 0, dann wird 100% die last_color genommen und 0% die goal_color. Wenn t == 1, dann anders herum. Für Werte zwischen 0 und 1 entsteht dann ne mischung (probiert mal aus die goal farbe zu rot zu setzen)

func ease_in_and_out(x: float) -> float:
	x = (sin(PI * (x - .5)) + 1) / 2
	return x

func ease_in(x: float) -> float:
	x = sin((PI / 2) * (x - 1)) + 1
	return x

func ease_out(x: float) -> float:
	x = sin((PI / 2) * x)
	return x

func load_next_scene(scene_path: String): #hier werden später neue scenen geladen, bspw der garten, andere räume, cafeteria etc.
	print('scene_path')
	set_color_to(Color(0, 0, 0, 1))

func _on_corridor_open_this_scene(scene_path): #das ist eine temporäre verknüpfung wird noch umgeändert
	load_next_scene('cooli')
