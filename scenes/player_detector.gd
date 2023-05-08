extends Sprite2D

@export var open_this_scene: String

signal player_entered(scene_path: String)

func _on_area_body_entered(body):
	if body.name == 'player':
		emit_signal('player_entered', open_this_scene)
