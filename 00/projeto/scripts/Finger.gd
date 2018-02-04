extends KinematicBody2D

const distancia_ruptura = 200
var pressionado = false

func _ready():
	$CollisionShape2D.set_disabled(true)
	pass

func _input(event):
	# Pula eventos de mouse para poder rodar no PC
	if event.get("button_mask") != null:
		return

	# print(event.as_text(), event.get_class())

	# Se o evento for um toque na tela
	if (event.get_class() == "InputEventScreenTouch"):
		# Verifica se foi pressionado ou solto
		if event.is_pressed():
			pressionado = true
			$CollisionShape2D.set_disabled(false)
		else :
			pressionado = false
			$CollisionShape2D.set_disabled(true)

	# Pega a posição e calcula o vetor distância entre o body e o toque
	var event_pos = event.get("position")
	var mover = event_pos - get_position()
	var colisao = move_and_collide(mover)

	# Se a distância for maior que ruptura "teletransporta" a colisão para a posição do dedo
	if mover.length() >= distancia_ruptura:
		set_position(event_pos)
		colisao = null

	# Se estiver pressionado mover o colisor de acordo com a distância calculada acima
	if (pressionado == true) :
		if (colisao != null):
			move_and_slide(colisao.remainder)
			if (colisao.normal == colisao.get_collider().lado):
				colisao.get_collider().queue_free()
			pass
