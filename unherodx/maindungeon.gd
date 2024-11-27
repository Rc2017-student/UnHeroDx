extends Node2D

@onready var deth = $AudioStreamPlayer2D2
@onready var music_player = $AudioStreamPlayer2D  # Asegúrate de que el nodo exista en la escena
func _ready():
	# Reproduce la música automáticamente al cargar la escena
	music_player.play()
	deth.play()


func _on_button_mouse_entered() -> void:
	pass # Replace with function body.
