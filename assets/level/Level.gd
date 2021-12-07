extends Node2D

export (PackedScene) var Enemy; # varaible para permitir el instanciamiento de la escena enemy desde el inspector


func _ready(): # recuerda que la funcion ready solo se ejecuta una vez.
	$Bg_Music.play(); # Esta es la otra forma de inciar la musica, esta forma es mediante codigo
	#Accedemos al nodo "BgMusic", mediante su metodo abreviado y ejecutamos la funcion "play()"
	$Timer.start(); # Accedemos al nodo ''Timer, y lo incializamos
	randomize(); #Funcion para generar aleatoriedad
	

func _physics_process(delta): # Esta funcion se ejecuta una vez en cada fotograma, a una velocidad constante de 60 fps (fotogramas por segundos), existe otra funcion llamada "process", pero esa funcion no tiene una velocidad constante
	#En esta funcion se utilizara el metodo extenso para acceder a un nodo(ya no get_tree), es mas extenso pero es mas versatil, hay que utilizar lo que nos convenga mejor 
	get_node("ParallaxBackground").scroll_base_offset      +=     Vector2(0,1) * 8  *                          delta;
	#Accedemos al nodo           Usamos su propiedad    Le sumamos       Le multiplicamos               Y le multiplicamos por delta que es una 
	#                            que es un vector2      otro vector2     por la velocidad deseada(8)    constante para que la velocidad no cambie en cada dispositivo
	
	
	# La propiedad scroll_base_offset, es una vector2, y le sumamos otro vector2  a scroll_base_offset, porque ese es el vector base de ese nodo, es decir, ese vector guarda la posicion actual del nodo
	# El vector2 contiene la informacion de direccion =, la cual sirve para especificar a donde debe moverse, mas la multiplicaciond de la velocidad, que en este caso es 8, y la multiplicacion de delta, para que la velocidad que se asigne se mantenga cosntante
	
	get_node("ParallaxBackground2-cloud1").scroll_base_offset += Vector2(0,1) * 24 * delta;	# como cloud1, es la ultima nube, esta debe pasar mas lento
	get_node("ParallaxBackground3-cloud2").scroll_base_offset += Vector2(0,1) * 34 *delta; # Aqui estaria yendo de 3 en 3 ha 34 fps





func _on_CanvasLayer_game_over(): #Señal creada en el script 'HUD', utilizando la palabra reservada 'signal'
	$Bg_Music.stop(); # Esta linea de codigo funciona para que cuando vuelva a empezar el nivel, no se interpongan la musica del hud, con el del level 
	


func _on_Timer_timeout(): # contiene las instrucciones de lo que se debe hacer cuando se acabe el tiempo
	get_node("Path2D/PathFollow2D").set_offset(randi()); # Accedemos al nodo 'PathFollow2D', recuerda que la funcion 'set_offset', sirve para insertar una posicion, en esta ocasion, la posicion va a ser aleatoria, por eso utilizamos la funcion "randi()"
	var enemy = Enemy.instance(); # Recuerda que ya eliminamos el enemigo de referencia, entonces lo instanciamos desde el inspector para que aparezca de forma random cuando acabe el tiempo del TIMER
	add_child(enemy); # Añadimos com hijo a la variable que tiene instanciado el enemigo.
	enemy.position = get_node("Path2D/PathFollow2D").position;
	$Timer.wait_time = GLOBAL.random(1,3); # Indicamos cuanto debe esperar el temporizador, en este caso utilizamos la variable GLOBAL, y utilizamos su funcion 'random', donde diremos que espere de un tiempo de 1 a 3 segundos
	$Timer.start();
