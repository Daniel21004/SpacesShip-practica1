extends Area2D

onready var player: KinematicBody2D = get_tree().get_nodes_in_group("player")[0];  #Obtenemos el nodo "player", porque lo vamos a utilizar en esta escena, en este caso se accede a el desde el arbol de escenas y atraves de los grupos, con el indice 0. Esto es porque si existiera otra escena que perteneciera al mismo grupo, nosotros necesitariamos indicar el indice en el que se encuentra la escena que queremos

const SPEED = 180;

func _ready():
	player.canShoot = false; #Accedemos a la variable "canShoot", de la escena player, porque la vamos a utilizar aqui, y le damos el valor de falso, para que no dispare al comienzo
	$AudioStreamPlayer.play(); # Recuerda que tambien se puede acceder a los nodos de la escena actual mediante este simbolo '$'
	$AnimatedSprite.play(); # inciamos la animacion
	
func _physics_process(delta):
	position.y -= SPEED * delta; # Accedemos a la posicion de la escena y le acumulamos la resta de SPEED * delta, recuerda que es resta porque '-y', es arriba y '+y' es abajo
	

func _on_Area2D_area_entered(area): # funcion para configurar la señal que recibe la bala
	if area.is_in_group("enemy"): # Aqui decimos, que en caso de que el area2D(la bala), envie una señal de que ha entrado dentro del grupo "enemy", entonces esta desaparecera
		queue_free(); #Funcion para que la escena desaparezca, en este caso la escena es la propia bala
		


func _on_VisibilityNotifier2D_screen_exited(): # Esta señal o funcion es de visibilityNotifier2D, que envia una señal si la escena ya no se muestra en pantalla, en este caso usamos la funcion "screenExit", que es la que sirve en caso la escena salga de pantalla
	player.canShoot = true; # indicamos que en el caso salga de pantalla, entonces se puede volver a disparar
	queue_free(); # tambien la hacemos desaparecer, porque si es que ha salido de pantalla es porque no ha colisionado con ningun enemigo


func _on_VisibilityNotifier2D_screen_entered():  # esta es una linea de codigo opcional, es una funcion del visibilityNotifier2D. Para cuando la escena esta en pantalla
	player.canShoot = true; #Agregue esta escena porque solo disparaba cuando salia de la pantalla y yo queria que pudiera disparar en todo momento
