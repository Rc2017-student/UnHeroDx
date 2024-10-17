extends CharacterBody2D

@export var velocidad: float = 50.0  # Velocidad del enemigo
@onready var animated_sprite = $AnimatedSprite2D  # Referencia al AnimatedSprite2D

var player_detected = false  # Si el enemigo ha detectado al jugador
var player = null  # Referencia al jugador
var lost_player_timer = 0.0  # Tiempo antes de que el enemigo se quede quieto
var is_paused = false  # Variable para saber si el enemigo está en pausa
var change_direction_time = 1.0  # Tiempo que el enemigo espera antes de cambiar dirección
var direction = Vector2.ZERO  # Dirección actual del movimiento
var timer = 0.0  # Contador para el cambio de dirección

func _ready():
	# Conectar las señales del campo de visión
	$Area2D.body_entered.connect(Callable(self, "_on_body_entered"))
	$Area2D.body_exited.connect(Callable(self, "_on_body_exited"))
	change_direction()  # Cambiar la dirección al inicio
	timer = change_direction_time  # Inicia el temporizador

func _process(delta):
	if is_paused:
		# Reducir el tiempo de pausa
		lost_player_timer -= delta
		if lost_player_timer <= 0:
			is_paused = false
		return

	var movimiento = Vector2.ZERO  # Vector para el movimiento del enemigo

	if player_detected and player != null:
		# Seguir al jugador si está dentro del campo de visión
		movimiento = (player.position - position).normalized() * velocidad
	else:
		# Movimiento aleatorio si no ha detectado al jugador
		timer -= delta
		if timer <= 0:
			# Cambiar dirección aleatoria
			change_direction()
			timer = change_direction_time  # Reinicia el temporizador
		movimiento = direction * velocidad

	# Mover el enemigo y manejar colisiones
	velocity = movimiento
	move_and_slide()

	# Si colisiona con el mapa
	if is_on_wall():
		is_paused = true  # Activar pausa
		lost_player_timer = change_direction_time  # Reiniciar el temporizador
		direction = Vector2.ZERO  # Detener el movimiento

	# Actualizar animación según la dirección del movimiento
	update_animation(movimiento)

func update_animation(movimiento):
	if movimiento.x > 0:
		animated_sprite.play("Walk_R")  # Mover a la derecha
	elif movimiento.x < 0:
		animated_sprite.play("Walk_L")  # Mover a la izquierda
	elif movimiento.y > 0:
		animated_sprite.play("Walk_R")  # Usar Walk_R para movimiento hacia abajo (puedes ajustar esto)
	elif movimiento.y < 0:
		animated_sprite.play("Walk_L")  # Usar Walk_L para movimiento hacia arriba (puedes ajustar esto)
	else:
		if animated_sprite.animation == "Walk_R":
			animated_sprite.play("Idle_R")  # Reproducir idle si no hay movimiento en X
		elif animated_sprite.animation == "Walk_L":
			animated_sprite.play("Idle_L")  # Reproducir idle si no hay movimiento en X

func change_direction():
	# Cambiar la dirección aleatoria
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()

func _on_body_entered(body):
	if body.name == "personaje":  # Cambia esto si el nombre del nodo jugador es diferente
		player_detected = true
		player = body
		is_paused = false  # Cancela la pausa si encuentra al jugador

func _on_body_exited(body):
	if body.name == "personaje":  # Cambia esto si el nombre del nodo jugador es diferente
		player_detected = false
		player = null
		is_paused = true  # Pausa de 3 segundos
		lost_player_timer = 3.0  # Reinicia el temporizador de pausa