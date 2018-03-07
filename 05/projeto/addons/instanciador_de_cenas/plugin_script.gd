tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("InstanciadorDeCenas", "Node2D", preload("instanciador_de_cenas.gd"), preload("icon.png"))
	pass

func _exit_tree():
	remove_custom_type("InstanciadorDeCenas")
	pass