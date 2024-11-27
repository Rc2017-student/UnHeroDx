extends Button

@onready var music_player = $"../AudioStreamPlayer2D"
@export var ruta_guardado: String = "user://game_data.dat"  # Ruta del archivo de guardado
@onready var personaje = $"../.."  # Ruta relativa al nodo del personaje

func _on_pressed() -> void:
	guardar_posicion_personaje()  # Llama a la función para guardar la posición
	get_tree().change_scene_to_file("res://menu.tscn")  # Cambia de escena

func _on_mouse_entered() -> void:
	music_player.play()

func guardar_posicion_personaje():
	if personaje:  # Asegúrate de que el nodo del personaje exista
		var datos = {}
		datos["player_position"] = [personaje.position.x, personaje.position.y]  # Guarda las coordenadas
		var archivo = FileAccess.open(ruta_guardado, FileAccess.WRITE)
		archivo.store_var(datos)  # Guarda los datos en el archivo
		archivo.close()  # Cierra el archivo
		print("Posición guardada:", datos["player_position"])
	else:
		print("No se encontró el nodo del personaje.")
