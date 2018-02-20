extends "res://personagens/Personagem.gd"

signal direcao_alterada

""" Velocidade máxima sem nenhum tipo de efeito que deixe o personagem
mais lento ou mais rápido """
const VELOCIDADE_MAXIMA_PADRAO = 300

func _ready():
	# Inicial a velocidade máxima do personagem com a do jogador.
	velocidade_maxima_atual = VELOCIDADE_MAXIMA_PADRAO
	pass

""" IMPORTANTE: o _process do jogador irá rodar antes do _process
do personagem, mas os dois serão processados. Como o jogador
herdou o personagem podemos dizer que o jogador é filho
do personagem. """

func _physics_process(delta):
	""" Esta variável foi declarada no script personagem.gd
	Como esse script o herda ele também possui a variável. """
	direcao_entrada = Vector2()
	
	""" .is_action_pressed testa se uma ação foi pressionada e retorna true
	caso tenha sido pressionada e false caso não. Aqui usamos float() para
	converter o resultado em um número (1.0 para true e 0.0 para false) e
	somamos os resultados de direita e esquerda para obter o resultado.
	Caso os dois sejam pressionados simultâneamente então direcao_entrada.x
	é 0 e o jogador não se move. Caso apenas direita temos resultado 1 (ou
	seja, movimento positivo no eixo x) e caso esquerda -1 (movimento
	negativo). """
	direcao_entrada.x = float(Input.is_action_pressed("direita")) - float(Input.is_action_pressed("esquerda"))
	pular_pressionado = Input.is_action_pressed("pular")
	
	""" Criamos um sinal que avisa todos os nós que se inscreverem nele que
	o personagem mudou de dieração. Útil para animações, inteligência
	artificial de inimigos (que podem tomar uma decisão com base nisso)
	entre outras coisas. """
	if direcao_entrada and direcao_entrada != direcao_ultimo_movimento:
		emit_signal("direcao_alterada", direcao_entrada)
	pass
