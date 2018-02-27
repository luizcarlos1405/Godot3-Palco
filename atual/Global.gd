extends Node

var tempo = 0.0

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

func _process(delta):
	tempo = tempo + delta