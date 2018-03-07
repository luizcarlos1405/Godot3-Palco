extends Node

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("cima"):
		get_node("InstanciadorDeCenas").instanciar()