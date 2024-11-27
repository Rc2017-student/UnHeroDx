extends Node2D
@export var ruta_guardado: String = "user://game_data.dat"  # Ruta del archivo de guardado
@onready var retry = $Sprite2D/Button
@onready var music_player = $AudioStreamPlayer2D
@onready var buton = $Sprite2D/AudioStreamPlayer2D
func _on_button_pressed() -> void:
	resetear_datos_guardados()
	get_tree().change_scene_to_file("res://maindungeon.tscn")

func _ready():
	# Reproduce la música automáticamente al cargar la escena
	music_player.play()

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

func _on_button_mouse_entered() -> void:
	buton.play()
