extends Node2D

signal open_this_scene(scene_path: String)

func _on_left_exit_player_entered(scene_path):
	emit_signal('open_this_scene', scene_path)
