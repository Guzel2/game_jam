extends Node2D

signal open_this_scene(scene_path: String) #signale sind gut um gut verwendbare objekte zu schreiben

@onready var bg = $bg
@onready var size = bg.get_rect().size

var set_player_position_to = Vector2(-325, 60) #sehr hässliche lösung, kann man gerne umändern

func _on_left_exit_player_entered(scene_path):
	emit_signal('open_this_scene', scene_path)
