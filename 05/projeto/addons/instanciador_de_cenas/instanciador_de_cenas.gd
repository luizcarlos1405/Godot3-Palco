tool
extends Node2D

export(PackedScene) var cena setget set_cena

var contador = 0

func _ready():
	atualizar()
	pass

func set_cena(valor):
	cena = valor
	
	atualizar()

func instanciar():
	var instancia = cena.instance()
	instancia.set_name(str(instancia.get_name(), contador))
	
	add_child(instancia)
	
	contador += 1
	
	return instancia

func atualizar():
	if Engine.editor_hint:
		for filho in get_children():
			filho.queue_free()
		
		if cena == null :
			var sprite = Sprite.new()
			var texture = preload("placeholder.png")
			texture.set_flags(0)
			
			sprite.set_texture(texture)
			
			add_child(sprite)
		else :
			add_child(cena.instance())