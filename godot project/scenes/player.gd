extends CharacterBody2D

var speed = 200.0

func _process(_delta): #wird jeden frame gecalled, delta ist die zeit seit dem letzten frame, meistesn 1/60, kann aber bei framdrops sich ändern
	var dir = Vector2(0, 0) #jeden frame wird die richtung auf 0 gesetzt, dadurch ist das movement sehr ruck haft, können überlegen ob es anders besser wäre
	
	dir.x = Input.get_axis('left', 'right') #hier wird der linke input mit dem rechten verglichen. Dabei kommen werte zwischen -1 und 1 raus (-1 = liks, 1 = rechts). Auf einem joystick könnte man 0.XX werte kriegen, mit einer Tastatur nicht
	dir.y = Input.get_axis('up', 'down') #vgl oben
	
	dir = dir.normalized() #damit diagonale inputs immer noch die länge 1 haben
	
	velocity = dir * speed #die richtung wird mit der geschwindigkeit multipliziert

	move_and_slide() #das ist eine eingebaute function die mit sachen collidiert. so etwa kann man leicht an einer wand lang sliden
	#eine alternative idee ohne collision ist folgendes:
	#position += dir * speed * (delta * 60) #hier wird noch delta * 60 dazu gerechnet, damit bei framedrops der char gleich schnell ist
