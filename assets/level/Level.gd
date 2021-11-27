extends Node2D

func _ready(): # recuerda que la funcion ready solo se ejecuta una vez.
	$Bg_Music.play(); # Esta es la otra forma de inciar la musica, esta forma es mediante codigo
	#Accedemos al nodo "BgMusic", mediante su metodo abreviado y ejecutamos la funcion "play()"
	

func _physics_process(delta): # Esta funcion se ejecuta una vez en cada fotograma, a una velocidad constante de 60 fps (fotogramas por segundos), existe otra funcion llamada "process", pero esa funcion no tiene una velocidad constante
	#En esta funcion se utilizara el metodo extenso para acceder a un nodo(ya no get_tree), es mas extenso pero es mas versatil, hay que utilizar lo que nos convenga mejor 
	get_node("ParallaxBackground").scroll_base_offset      +=     Vector2(0,1) * 8  *                          delta;
	#Accedemos al nodo           Usamos su propiedad    Le sumamos       Le multiplicamos               Y le multiplicamos por delta que es una 
	#                            que es un vector2      otro vector2     por la velocidad deseada(8)    constante para que la velocidad no cambie en cada dispositivo
	
	
	# La propiedad scroll_base_offset, es una vector2, y le sumamos otro vector2  a scroll_base_offset, porque ese es el vector base de ese nodo, es decir, ese vector guarda la posicion actual del nodo
	# El vector2 contiene la informacion de direccion =, la cual sirve para especificar a donde debe moverse, mas la multiplicaciond de la velocidad, que en este caso es 8, y la multiplicacion de delta, para que la velocidad que se asigne se mantenga cosntante
	
	get_node("ParallaxBackground2-cloud1").scroll_base_offset += Vector2(0,1) * 24 * delta;	# como cloud1, es la ultima nube, esta debe pasar mas lento
	get_node("ParallaxBackground3-cloud2").scroll_base_offset += Vector2(0,1) * 34 *delta; # Aqui estaria yendo de 3 en 3 ha 34 fps
