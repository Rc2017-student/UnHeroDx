extends Node2D

@onready var retry = $Sprite2D/Button
@onready var music_player = $AudioStreamPlayer2D
@onready var buton = $Sprite2D/AudioStreamPlayer2D
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://maindungeon.tscn")

func _ready():
	# Reproduce la música automáticamente al cargar la escena
	music_player.play()



func _on_button_mouse_entered() -> void:
	buton.play()
