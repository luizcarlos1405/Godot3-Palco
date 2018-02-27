extends "res://personagens/MovimentoFlutuante.gd"

onready var jogador = get_parent().get_node("Jogador")

func _physics_process(delta):
	""" Aqui calculamos o ponto para qual a arma deve se dirigir e também
	algumas variáveis a serem utilizadas (vetor, direção e tamanho). """
	var ponto = jogador.get_position() + Vector2(cos(global.tempo * 2) * 20, sin(global.tempo * 1.4) * 10 - 20)
	var vetor = ponto - get_position()
	var direcao = vetor.normalized()
	var distancia = vetor.length()
	
	# Se já tiver chegado ao destino a direcao que ele deve ir é 0
	if distancia < velocidade_atual.length() * delta + 1:
		direcao = Vector2()
	
	""" Define a direcao entrada e varia a velociade máxima para um movimento
	mais suave. """
	direcao_entrada = direcao
	velocidade_maxima_atual = pow(distancia, 1.5) + 50
	pass
