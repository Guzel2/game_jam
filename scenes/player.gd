extends CharacterBody2D


var speed = 100.0


func _process(delta):
	var dir = Vector2(0, 0)
	
	dir.x = Input.get_axis('left', 'right')
	dir.y = Input.get_axis('up', 'down')
	
	velocity = dir * speed

	move_and_slide()
