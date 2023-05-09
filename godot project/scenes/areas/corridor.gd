extends Node2D

signal open_this_scene(scene_path: String) #signale sind gut um gut verwendbare objekte zu schreiben

@onready var bg = $bg
@onready var size = bg.get_rect().size

var set_player_position_to = Vector2(125, 50)

func _on_right_exit_player_entered(scene_path):#wenn der exit rechts einen spieler erkennt wird hier ausgelöst
	emit_signal('open_this_scene', scene_path)


func _on_wash_room_exit_player_entered(scene_path):
	print('enter washroom')
	emit_signal('open_this_scene', scene_path)
