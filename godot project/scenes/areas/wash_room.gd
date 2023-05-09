extends Node2D

signal open_this_scene(scene_path: String) #signale sind gut um gut verwendbare objekte zu schreiben

@onready var bg = $bg
@onready var size = bg.get_rect().size

var set_player_position_to = Vector2(0, 0)

func _on_exit_player_entered(scene_path):
	print('hello')
	emit_signal('open_this_scene', scene_path)
	set_player_position_to = Vector2(-140, 200)
