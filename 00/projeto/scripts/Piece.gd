extends KinematicBody2D

var lado = Vector2(1, 0)

func _ready():
	var lados = [Vector2(1, 0), Vector2(-1, 0), Vector2(0, 1), Vector2(0, -1)]
	
	randomize()
	lado = lados[randi()%4]
	
	if (lado == lados[1]):
		rotate(deg2rad(180))
	elif (lado == lados[2]):
		rotate(deg2rad(90))
	elif (lado == lados[3]):
		rotate(deg2rad(-90))
	pass

#func _physics_process(delta):
#
#	pass
