extends "res://personagens/MovimentoFlutuante.gd"

onready var jogador = get_parent().get_node("Jogador")

func _physics_process(delta):
	var ponto = jogador.get_position() + Vector2(cos(global.tempo * 2) * 20, sin(global.tempo * 1.4) * 10 - 20)
	var vetor = ponto - get_position()
	var direcao = vetor.normalized()
	var distancia = vetor.length()
	
	if distancia < velocidade_atual.length() * delta + 1:
		direcao = Vector2()
	
	direcao_entrada = direcao
	velocidade_maxima_atual = pow(distancia, 1.5) + 50
	pass
