extends Node2D

@export var vida: int = 5  # Vida inicial del enemigo en batalla
@export var max_vida: int = 5  # Vida máxima del enemigo
@export var daño: int = 1  # Daño base que puede causar el enemigo


func atacar() -> int:
	var probabilidad = randi_range(0, 100)
	if probabilidad < 40:
		return 0
	elif probabilidad <= 90 and probabilidad > 40:
		return 1
	else:
		return 2
