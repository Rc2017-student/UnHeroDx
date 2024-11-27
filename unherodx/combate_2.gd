extends Node2D

# Variables de vida y daño
var vida_jugador: int = 20
var max_vida_jugador: int = 20
var vida_enemigo: int = 15
var max_vida_enemigo: int = 15
var dano_jugador_minimo: int = 0
var dano_jugador_max: int = 4
@onready var music_player = $AudioStreamPlayer2D 
@onready var buton = $Control/AudioStreamPlayer2D
@onready var punch = $Control/AudioStreamPlayer2D2
@onready var slash = $Control/AudioStreamPlayer2D3
@onready var barra_de_vida_jugador = $Control/BarraDeVidaJugador
@onready var barra_de_vida_enemigo = $Control/BarraDeVidaEnemigo
@onready var boton_atacar = $Control/BotonAtacar
@onready var label_mensajes = $Control/LabelMensaje

func _ready():
	music_player.play()
	actualizar_barras_de_vida()
	label_mensajes.text = "¡El combate ha comenzado!"
	boton_atacar.connect("pressed", Callable(self, "_on_boton_atacar_pressed"))

func actualizar_barras_de_vida():
	barra_de_vida_jugador.value = vida_jugador * 100 / max_vida_jugador
	barra_de_vida_enemigo.value = vida_enemigo * 100 / max_vida_enemigo

func _on_boton_atacar_pressed():
	punch.play()
	slash.play()
	atacar_enemigo()
	if vida_enemigo <= 0:
		fin_combate_ganado()
	else:
		enemigo_ataca()

func atacar_enemigo():
	var daño = randi_range(dano_jugador_minimo, dano_jugador_max)  # Daño aleatorio entre 0 y 2 para el jugador
	vida_enemigo -= daño
	label_mensajes.text = "Has hecho " + str(daño) + " de daño al enemigo."
	actualizar_barras_de_vida()

func enemigo_ataca():
	var daño = calcular_daño_enemigo()
	vida_jugador -= daño
	label_mensajes.text += "\nEl enemigo te ha hecho " + str(daño) + " de daño."
	actualizar_barras_de_vida()

	if vida_jugador <= 0:
		fin_combate_perdido()

func calcular_daño_enemigo() -> int:
	var probabilidad = randi_range(0, 100)
	if probabilidad < 40:
		return 1
	elif probabilidad <= 90 and probabilidad > 40:
		return 2
	else:
		return 3

func fin_combate_ganado():
	# Cargar datos guardados
	var ruta = "user://game_data.dat"
	var Datos: Dictionary = {}
	if FileAccess.file_exists(ruta):
		var archivo = FileAccess.open(ruta, FileAccess.READ)
		Datos = archivo.get_var()
		archivo = null
	# Guardar los datos actualizados
	var archivo = FileAccess.open(ruta, FileAccess.WRITE)
	archivo.store_var(Datos)
	archivo = null
	
	# Cambiar de vuelta a la escena principal
	get_tree().change_scene_to_file("res://maindungeon.tscn")



func fin_combate_perdido():
	label_mensajes.text = "Has sido derrotado."

	get_tree().change_scene_to_file("res://gameOver.tscn")
  # Cerrar la escena de combate


func _on_boton_atacar_mouse_entered() -> void:
	buton.play()
