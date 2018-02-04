extends Node

var peca_scene = preload("res://scenes/Piece.tscn")
var espera = 2
var tempo = 0

func _ready():
	randomize()
	pass

func _process(delta):
	tempo += delta
	
	if (tempo >= espera) :
		tempo = 0
		
		var nova_peca = peca_scene.instance()
		
		add_child(nova_peca)
		
		nova_peca.set_position(Vector2(rand_range(100, 620), rand_range(100, 980)))
		
		espera = rand_range(1, 3)
	pass
