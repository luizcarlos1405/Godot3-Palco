extends KinematicBody2D

export var aceleracao = 4000

var velocidade_maxima_atual = 500
var velocidade_alvo = 0.0
var velocidade_atual = Vector2()

var direcao_entrada = Vector2()
var direcao_ultimo_movimeno = Vector2()

onready var global = get_node("/root/Global")

func _physics_process(delta):
	if direcao_entrada:
		direcao_ultimo_movimeno = direcao_entrada
		
		if velocidade_alvo != velocidade_maxima_atual:
			velocidade_alvo = velocidade_maxima_atual
	else :
		velocidade_alvo = 0
	
	var variacao = Vector2()
	variacao.x = aceleracao * abs(direcao_ultimo_movimeno.x) * delta
	variacao.y = aceleracao * abs(direcao_ultimo_movimeno.y) * delta
	
	velocidade_atual.x = global.aproximar(velocidade_atual.x, velocidade_alvo * direcao_ultimo_movimeno.x, variacao.x)
	velocidade_atual.y = global.aproximar(velocidade_atual.y, velocidade_alvo * direcao_ultimo_movimeno.y, variacao.y)
	
	move_and_slide(velocidade_atual)