extends KinematicBody2D

signal velocidade_alterada

export var aceleracao = 4000
export var desaceleracao = 3000

var direcao_entrada = Vector2()
var direcao_ultimo_movimento = Vector2(1, 0)

# Velocidade máxima possível atualmente.
var velocidade_maxima_atual = 0.0

# Velocidade que o personagem quer alcançar.
var velocidade_alvo = 0.0

""" A velocidade em pixels por segundo que será usada para efetivamente
mover o personagem em x e em y. """
var velocidade_atual = Vector2()

""" Para movimento e cálculos de física é recomendado o _physics_process
no lugar de _process. """
func _physics_process(delta):
	""" Caso, no _process do jogador ou I.A. (que roda antes deste)
	não tenha sido recebido nenhuma entrada, ou seja, nenhuma ação
	de movimento foi pressionada, direcao_entrada terá x == 0 e
	y == 0 e para o if isso significa false. """
	if direcao_entrada:
		""" E então atualizamos o último movimento, pois é a variável
		que guarda a última entrada de movimento do jogador. """
		direcao_ultimo_movimento = direcao_entrada
		
		if velocidade_alvo != velocidade_maxima_atual:
			""" Se o personagem está tentando se mover então quer alcançar
			a velocidade máxima. Atualiza se já não for igual. """
			velocidade_alvo = velocidade_maxima_atual
	else:
		""" Se o personagem não está entando se mover é porque quer parar,
		ou seja, alcançar a velocidade zero. """
		velocidade_alvo = 0
	
	# VELOCIDADE EM X
	""" Calculamos se a velocidade irá variar com o valor de aceleração ou
	de desaceleração. Para isso precisamos apenas saber se há direção de
	entrada em x, pois se o personagem estiver tentando se mover usaremos
	a aceleração tanto para acelerá-lo quanto para freiá-lo. Já se ele
	não estiver tentando acelerar para nenhum lado usaremos a
	desaceleração para que ele vá parando sozinho. """
	var variacao = desaceleracao * delta
	if direcao_entrada.x != 0:
		variacao = aceleracao * delta
	
	""" Usamos a função aproximar (definida abaixo) para aproximar o valor
	da velocidade_atual.x para a velocidade_alvo com a variação calculada
	acima (ou seja, numa taxa de aceleracao ou desaceleracao por segundo. """
	velocidade_atual.x = aproximar(velocidade_atual.x, velocidade_alvo * direcao_entrada.x, variacao)
	
	""" Função move_and_slide move e desliza o jogador por um body
	caso seja necessário. Esta função também multiplica o argumento
	passado por delta, já fazendo a variação no tempo. é a forma mais
	simples de mover e já tratar as colisões. """
	move_and_slide(velocidade_atual)
	pass

""" Essa função aproxima o valor atual para o final em uma taxa linear
de variacao por chamada da função. Um pouco complicado de entender mesmo.
Para mais informações estude interpolação linear. """
func aproximar(valor_atual, valor_alvo, variacao):
	var diferenca = valor_alvo - valor_atual
	
	if diferenca > variacao:
		return valor_atual + variacao
	if diferenca < -variacao:
		return valor_atual - variacao
	
	return  valor_alvo
	pass
