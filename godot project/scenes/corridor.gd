extends Node2D

signal open_this_scene(scene_path: String) #signale sind gut um gut verwendbare objekte zu schreiben

func _on_left_exit_player_entered(scene_path): #wenn der exit links einen spieler erkennt wird hier ausgelöst
	emit_signal('open_this_scene', scene_path)
