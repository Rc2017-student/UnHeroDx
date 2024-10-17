extends CharacterBody2D

@export var velocidad: float = 70.0  # Velocidad del personaje
@onready var animated_sprite = $AnimatedSprite2D  # Referencia al AnimatedSprite2D

func _process(delta):
	var movimiento = Vector2.ZERO  # Inicializamos un vector de movimiento

	# Detectar las entradas del usuario para mover al personaje
	if Input.is_action_pressed("ui_left"):  # Tecla izquierda
		movimiento.x -= 1
		animated_sprite.play("Walk_L")  # Reproducir animación de caminar a la izquierda
	elif Input.is_action_pressed("ui_right"):  # Tecla derecha
		movimiento.x += 1
		animated_sprite.play("Walk_R")  # Reproducir animación de caminar a la derecha
	elif Input.is_action_pressed("ui_up"):  # Tecla arriba
		movimiento.y -= 1
		animated_sprite.play("Walk_R")  # Usar animación de caminar a la derecha
	elif Input.is_action_pressed("ui_down"):  # Tecla abajo
		movimiento.y += 1
		animated_sprite.play("Walk_R")  # Usar animación de caminar a la derecha
	else:
		# Si no se mueve, reproducir la animación de idle
		if animated_sprite.animation == "Walk_L":
			animated_sprite.play("Idle_L")  # Reproducir animación de idle a la izquierda
		elif animated_sprite.animation == "Walk_R":
			animated_sprite.play("Idle_R")  # Reproducir animación de idle a la derecha

	# Normalizar el movimiento para evitar que el personaje se mueva más rápido en diagonal
	movimiento = movimiento.normalized() * velocidad
	velocity = movimiento  # Asignar la velocidad al nodo

	# Mover el personaje y gestionar colisiones
	move_and_slide()  # Mueve el personaje y maneja las colisiones
