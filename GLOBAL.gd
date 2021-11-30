extends Node

# Este script se llama singleton, la cual es un script que va a ser utilizado por todo los scripts del juego
onready var score: int; # variable para contabilizar la puntuacion 
onready var rng: RandomNumberGenerator = RandomNumberGenerator.new(); # utilizamos la variable "rng", como un generador de numeros

func random(valorMinimo, valorMaximo): # En esta funcion recibirimos dos parametros, un valor minimo y un maximo
	rng.randomize(); # funcion para generar la aletoriedad
	var random = rng.randf_range(valorMinimo, valorMaximo); #utilizando la variable "rng", que ya tiene un estado de aletoriedad, accedemos a su metodo "ranndf_range" para establecer los valores minimos y maximos
	return random; # retornamos el numero aleatorio

