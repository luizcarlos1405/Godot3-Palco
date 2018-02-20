extends KinematicBody2D

signal velocidade_alterada

export var aceleracao = 3000
export var desaceleracao = 3000
export var aceleracao_gravidade = 1500
export var velocidade_queda = 600
export var fator_pulo_fraco = 2

var direcao_entrada = Vector2()
var direcao_ultimo_movimento = Vector2(1, 0)
var pular_pressionado = false
var cima = Vector2(0, -1)

# Velocidade máxima possível atualmente.
var velocidade_maxima_atual = 0.0

# Velocidade que será dada ao jogador ao pular
var velocidade_pulo = -500

# Velocidade que o personagem quer alcançar em x e em y.
var velocidade_alvo = 0.0

""" A velocidade em pixels por segundo que será usada para efetivamente
mover o personagem em x e em y. """
var velocidade_atual = Vector2()

""" Para movimento e cálculos de física é recomendado o _physics_process
no lugar de _process. """
func _physics_process(delta):
	
	# Função que lida com todo o movimento no eixo x do personagem.
	_movimento_horizontal(delta)
	
	# Função que lida com todo o movimento no eixo y do personagem.
	_movimento_vertical(delta)
	
	""" Função move_and_slide move e desliza o jogador por um body
	caso seja necessário. Esta função também multiplica o argumento
	passado por delta, já fazendo a variação no tempo. é a forma mais
	simples de mover e já tratar as colisões. """
	move_and_slide(velocidade_atual, cima)

func _movimento_horizontal(delta):
	""" Caso, o _process do jogador ou I.A. (que roda antes deste)
	não tenha sido recebido nenhuma entrada, ou seja, nenhuma ação
	de movimento foi pressionada, direcao_entrada terá x == 0 e para
	o if isso significa false. """
	if direcao_entrada.x:
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
	acima (ou seja, numa taxa de aceleracao ou desaceleracao por segundo). """
	velocidade_atual.x = aproximar(velocidade_atual.x, velocidade_alvo * direcao_entrada.x, variacao)

func _movimento_vertical(delta):
	# Se o personagem estiver no chão
	if is_on_floor():
		# Zeramos a velocidade em 0
		velocidade_atual.y = 0
		# E se ele estiver pressionando o botão para pular e está no chão
		if pular_pressionado:
			# Aplicamos a velocidade de pulo
			velocidade_atual.y = velocidade_pulo
	
	# Se o personagem bater a cabeça no teto sua velocidade em y também é zerada
	if is_on_ceiling():
		velocidade_atual.y = 0
	
	""" Calculamos a variação da velocidade em y levando em conta a aceleracao
	da gravidade no jogo. """
	var variacao = aceleracao_gravidade * delta
	""" Se o botão de pular não estiver sendo pressionado e a velocidade
	em y estiver negativa (personagem indo pra cima), aplicamos uma
	gravidade mais forte multiplicando pelo fator de pulo fraco que dita a
	diferença de segurar o botão de pulo ou soltar rapidamente. """
	if not pular_pressionado and velocidade_atual.y < 0:
		variacao = variacao * fator_pulo_fraco
	
	# Finalmente aplica-se a velociade em y
	velocidade_atual.y = aproximar(velocidade_atual.y, velocidade_queda, variacao)

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
