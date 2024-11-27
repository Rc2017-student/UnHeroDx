extends Button

@export var escena_inicial: String = "res://maindungeon.tscn"  # Ruta de tu escena inicial
@export var ruta_guardado: String = "user://game_data.dat"  # Ruta del archivo de guardado

@onready var audio_player = $"../AudioStreamPlayer2D"  # Referencia al nodo de sonido

func _on_pressed():
	resetear_datos_guardados()
	get_tree().change_scene_to_file(escena_inicial)  # Cambia a la escena inicial

func resetear_datos_guardados():
	if FileAccess.file_exists(ruta_guardado):
		var dir = DirAccess.open("user://")
		if dir != null and dir.file_exists("game_data.dat"):
			dir.remove("game_data.dat")  # Elimina el archivo de guardado
			print("Archivo de guardado eliminado. Nueva partida iniciada.")
		else:
			print("No se encontró el archivo de guardado para eliminar.")
	else:
		print("No se encontró archivo de guardado. Iniciando una nueva partida.")

func _on_mouse_entered() -> void:
	# Reproducir sonido al entrar el mouse
	if audio_player.stream:
		audio_player.play()
