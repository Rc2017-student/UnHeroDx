extends CharacterBody2D
@onready var area_2d = $Area2D  # Referencia al primer Area2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "personaje":
		get_tree().change_scene_to_file("res://BOSSbatle.tscn")  # Cambia a la escena de combate
