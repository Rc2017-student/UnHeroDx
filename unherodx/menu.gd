extends Node2D

@onready var music_player = $AudioStreamPlayer2D2  # Asegúrate de que el nodo exista en la escena

func _ready():
	# Reproduce la música automáticamente al cargar la escena
	music_player.play()
