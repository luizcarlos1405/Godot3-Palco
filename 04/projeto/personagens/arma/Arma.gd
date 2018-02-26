extends "res://personagens/MovimentoFlutuante.gd"

const VELOCIDADE_MAXIMA_PADRAO = 100

onready var jogador = get_parent().get_node("Jogador")

func _ready():
	velocidade_maxima_atual = VELOCIDADE_MAXIMA_PADRAO
	pass

func _physics_process(delta):
	direcao_entrada = Vector2()
	
	va_para(jogador.get_position() + Vector2(cos(global.tempo*2)*20, sin(global.tempo*1.4)*10 - 20), delta)

""" Dado um ponto e a variável delta essa função leva a arma até lá """
func va_para(ponto, delta):
	var vetor = ponto - get_position()
	var direcao = vetor.normalized()
	var distancia = vetor.length()
	
	if distancia < velocidade_atual.length() * delta + 1:
		direcao = Vector2()
	
	velocidade_maxima_atual = pow(distancia, 1.5) + 50
	direcao_entrada = direcao