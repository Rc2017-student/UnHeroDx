extends Area2D

signal vida_aumentada(cantidad)

@export var cantidad_vida_extra: int = 1  # La cantidad de vida extra que proporciona este objeto.


func _on_body_entered(body):
	if body.has_method("agregar_vida_extra"):  # Verifica si el objeto tocado tiene el método "agregar_vida_extra".
		body.agregar_vida_extra(cantidad_vida_extra)
	queue_free()  # Destruye el objeto después de ser tocado.
