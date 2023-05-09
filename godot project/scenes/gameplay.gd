extends Node2D

@onready var player = $player #da wird der spieler gespeichert um von wo anders drauf zu zugreifen
@onready var camera = $camera

var current_area

var time = -1
var time_to_transition = .5

var goal_color
var last_color

var camera_area = Vector2(100, 100)

var area_to_load = ''

func _ready():
	load_next_area("res://scenes/areas/corridor.tscn")
	modulate = Color(0, 0, 0, 1)
	set_color_to(Color(1, 1, 1, 1))

func _process(delta): #wird jeden frame gecalled, delta ist die zeit seit dem letzten frame, meistesn 1/60, kann aber bei framdrops sich ändern
	if time >= 0:
		var t = time / time_to_transition #dadurch krieg ich zahlen zwischen 0 und 1 (bspw 0.345)
		
		t = ease_in_and_out(t) #sinus function, dadurch wird t "weicher" insbesondere bei bewegung hilfreich, kann man hier eigentlich weglassen
		
		change_color(t)
		
		time += delta
		if time > time_to_transition:
			time = -1
			modulate = goal_color
			
			if area_to_load != '':
				load_next_area(area_to_load)
				area_to_load = ''
				set_color_to(Color(1, 1, 1, 1))
	
	set_camera_position()

func set_camera_position():
	var new_camera_pos = Vector2(0, 0) #resets the camera position
	new_camera_pos.x = clamp(player.position.x, -camera_area.x, camera_area.x) #clamp makes it so that the first value is between the other 2 values
	new_camera_pos.y = clamp(player.position.y, -camera_area.y, camera_area.y) #for example: clamp(-3, -1, 1) = -1; clamp(30, 20, 40) = 30; clamp(30, 20, 25) = 25
	camera.position = new_camera_pos

func set_color_to(new_color: Color): #startet den timer und setzt neue zielfarben
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

func load_scene(scene_path: String):#hier werden später neue scenen geladen, bspw der garten, andere räume, cafeteria etc.
	var scene = load(scene_path).instantiate() #eingebaute functions, muss man so machen
	add_child(scene) #siehe oben
	
	return scene #return ermöglicht es einen werte zwischen functions zu schicken. Hier wird die locale variabel 'scene' nach aussen geschickt

func load_next_area(scene_path: String):
	if current_area:
		current_area.queue_free() #enfernt die alte area
	current_area = load_scene(scene_path) #lädt die nächste area und nimmt die versendete variable an
	
	set_camera_area(current_area.size) #gets the size of the new area
	
	player.position = current_area.set_player_position_to #das ist eine temporäre lösung, kann man gerne ändern
	
	var my_callable = Callable(self, 'start_transition_to_next_area') #das hier verbindet das signal 'open_this_scene' von den areas mit der function 'start_transition_to_next_area'
	current_area.connect('open_this_scene', my_callable) #das sind alles vorgefertigte functions, muss man so machen

func start_transition_to_next_area(scene_path: String):
	area_to_load = scene_path
	set_color_to(Color(0, 0, 0, 1))

func set_camera_area(new_size): #rename this function and the variables, they suck
	var viewport_size = get_viewport_rect().size #gets the resolution of the screen, currently 320 x 180
	
	camera_area = (new_size - viewport_size) / 2 #sets margins for the camera to move in
	
	print(camera_area)
