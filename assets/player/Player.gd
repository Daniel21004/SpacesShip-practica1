extends KinematicBody2D

export (PackedScene) var Shoot;  #  el PackedScene, sirve para indicar una escena que "AUN NO SE HA CREADO PERO SE CREARÁ MÁS ADELANTE", y el "export", es porque aun no tenemos la ruta de esa escena, por eso la creamos con export

const SPEED = 100; # Constante de Velocidad

onready var motion = Vector2.ZERO; # Ponemos "onready", para ya no tener que ponerla en la funcion "ready", es un metodo bastante aberviado, la variable "motion", va a ser para el movimiento, y como es movimiento recuerda que se mueve en vetores, por eso el Vector2, que hace referencia al movimiento en 2D, la palabra ZERO, es igual a tener Vector2(0,0);
onready var canShoot : bool = true;
onready var screenSize = get_viewport_rect().size; # Utilizamos esta variable para obtener el viewport y la funcion "size", para que nos devuelva el tamaño

func _ready():
	$AnimatedSprite.play();
	
func _physics_process(delta):  # Recuerda que esta funcio sirve para simular cosas fisicas
	motion_ctrl();
	animation_ctrl();
	motion = move_and_collide(motion * delta); # controla el movimiento y la multiplica por delta, para que esta sea constante, move_and_collide, es un metodo comun para mover cuerpos fisicos.
	

func _input(event): #Funcion nativa de godot, que captura un evento de entrada y actua de acuerdo a las lineas de codigo que tiene dentro de el 
	if event.is_action_pressed("ui_accept") and canShoot: # Verificamos que aplastaron la tecla "Space" y si pueden dispara
		shoot_ctrl(); # En caso sea verdad, se ejecutar el "shoot_ctrl()"

#Retorna los ejes para saber hacia donde se esta moviendo
func get_axis() -> Vector2: # Funcion para obtener los ejes, este simbolo "->", significa que va a retornar algo, en este caso un Vector2, porque lo vamos a utilizar para el movimiento
	var axis = Vector2.ZERO; # Declarar la variable que contendra la informacion de los axis, la incializamos como un vector 0, ya que como obtendra los ejes para el movimiento, necesitamos que este sea retornado de vectores
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"));  # no retorna 1 o 0 o -1
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up")); #Es lo mismo solo que para arriba
	#el casteo se hace solo con el tipo de dato sin parentesis, no : (tipo de dato)
	return axis;

	
func motion_ctrl():  # Con esta funcion controlaremos la variable motion que es el movimiento. Necesitamos la funcion getAxis(), para poder saber los ejes
	if get_axis() == Vector2.ZERO:
		motion = Vector2.ZERO;
	else:
		motion = get_axis().normalized() * SPEED; # obtenemos el eje con "get_axis", para saber la direccion y para que se mueva es muy importante la velocidad, por eso lo multiplicamos por la constante SPEED y ponemos ".normalize()", para que cuando se mueva en diagonol, no cambie su velocidad y se matenga CONSTANTE
		
	#Limitar hacia donde puede ir
	
	position.x = clamp(position.x, 0 , screenSize.x); # Limitamos hacia donde se puede mover el jugador, para que no salga de la pantalla, para eso usamos la posicion del nodo que contiene el script, y el metodo clamp que recibe tres parametros:  clamp(posicionActual, posicionMinima, posicionMaxima)
	# En este caso la posicion actual va a ser "position.x", porque contiene la poscion actual donde sea que se encuentre la nave en el eje x. La posicion minima, va a ser cero. La posicion maxima, va a ser el tamaño de la pantalla, por eso declaramos una variable "screenSize", que contiene el tamaño de la ventana
	position.y = clamp(position.y, 0 , screenSize.y); # Recuerda indicar siempre los ejes cuando se trata de tamaños o vectores
	
	
	#Comportamiento de las animaiciones, recuerda que cualquier comportamiento debe de estar en funciones
func animation_ctrl():
	if get_axis().x == 1: #Comparamos el eje con 1, para saber si se mueve a la derecha
		$AnimatedSprite.animation = "Horizontal"; #Accedemos al nodo AnimationSprite y a su propiedad "animation", que recuerda es la que nos permite establecer una animacion por defecto, eso va a ser igual a la animacion que queremos que se ejevute, en este caso "Horizontal", se debe de esribir tal cual
		$AnimatedSprite.flip_h = true; #Como en este caso, la animacion esta para la izquierda, tenemos que voltearla con flip.h, que nos premite invertir una animacion en el eje horizontal
	elif get_axis().x == -1:
		$AnimatedSprite.animation = "Horizontal";
	else:
		$AnimatedSprite.animation = "Vertical";
		
func shoot_ctrl():
	var shoot = Shoot.instance(); #Guardamos en una variable el valor instanciado de Shoot
	shoot.global_position = $Position2D.global_position; # establecemos la posicion de shoot, con el metodo "global_position", la cual va a ser igual al "Position2D", que es el punto de spawneo de los disparos
	# Una vez indicada la posicion de shoot, tenemos que decirle donde es que queremos que aparezca, es decir, en que escena
	get_tree().call_group("level","add_child", shoot); # añade el nodo como hijo de los nodos que se encuentre dentro del grupo "level"
	
	
	# En la linea 57, instanciamos el Shoot, para poder trabajar con el en esta escena
	# En la linea 58, simplemente le indicamos la posicion donde queremos que salga
	# En la linea 60, instanciamos el nodo con la escena, accediendo al arbol de escenas e instanciadolo como un nodo hioj, mediante un grupo creado en la escena level
	
	
