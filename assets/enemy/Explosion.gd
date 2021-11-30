extends Node2D

#No te olvides de desactivar el loop en importar y reimportar de nuevo
func _ready():
	$AnimatedSprite.play();
	$AudioStreamPlayer.play();

func _on_AudioStreamPlayer_finished(): # funcion para programar lo que pasara cuando se termine el audio
	queue_free(); # Hacemos que la escena, la cual es la explosion, desaparezca
