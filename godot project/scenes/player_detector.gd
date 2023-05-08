extends Sprite2D

@export var open_this_scene: String

signal player_entered(scene_path: String) #signale sind gut um gut verwendbare objekte zu schreiben

func _ready(): #wird 1 mal am Anfang gecalled
	visible = false #die box wird unsichtbar gemacht, da nur die collision relevant ist

func _on_area_body_entered(body):
	if body.name == 'player': #wenn der body mit der erkannt wird der spieler ist, dann wird das signal "player_entered" versendet
		emit_signal('player_entered', open_this_scene)
