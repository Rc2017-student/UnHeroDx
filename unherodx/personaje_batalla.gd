extends Node2D

@export var vida: int = 5  # Vida inicial del personaje en batalla
@export var max_vida: int = 5  # Vida máxima para reiniciarse después del combate
@export var daño: int = 0  # Daño que puede causar en cada ataque (aleatorio en combate)


func atacar() -> int:
	# Daño aleatorio entre 0 y 2
	return randi_range(0, 2)

func restaurar_vida():
	# Restaura la vida del personaje al máximo al final de la batalla
	vida = max_vida
