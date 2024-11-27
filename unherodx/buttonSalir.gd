extends Button


func _on_pressed() -> void:
	get_tree().quit()
	
@onready var audio_player = $"../AudioStreamPlayer2D"  # Referencia al nodo de sonido
func _on_mouse_entered() -> void:
	# Reproducir sonido al entrar el mouse
	if audio_player.stream:
		audio_player.play()
