extends Area2D

export (PackedScene) var Explosion;
var speed; 

func _ready():
	$AnimatedSprite.play();
	speed = GLOBAL.random(32,42); # Como hemos generado un script global, se puede acceder a el facilmente y hacer uso de sus funciones, como lo es random, a la cual le diremos que queremos establecer una velocidad entre 32 y 42

func _physics_process(delta):
	position.y += speed * delta;


func death_enemy(): # utilizamos una funcion para no repetir codigo 
	queue_free(); # La escena desaparecerá
	explosion_ctrl();


func _on_Area2D_area_entered(area): #Funcion para programar que es lo que pasa cuando algo entra en el area
	if area.is_in_group("shoot"): #Decimos si lo que entra en el area pertenece al grupo shoot(añadimos a la escena shoot a un grupo shoot), entonces
		death_enemy(); 
		GLOBAL.score += 10; # Accedemos al singleton y accedemos a su variable score y le acumulamos 10


func _on_Area2D_body_entered(body): # funcion para programar lo que pasara cuando un cuerpo fisico choque con nosotros, lo cual recoredemos que ese es nuestro player.
	if body.is_in_group("player"):
		death_enemy(); # Llamamos a la funcion death_enemy, ya que es la que tiene las lineas de codigo que se ejecutaran cuando el enemigo muera
		body.queue_free(); # decimos que el cuerpo fisico que colisiono con nosotros, y que pertenece al grupo player, tambien debe de desaparecer


func explosion_ctrl():
	var explosion = Explosion.instance();
	explosion.global_position = $Position2D.global_position; #Ubicamos la escena instanciada en el position2d
	get_tree().call_group("level", "add_child", explosion); # No te olvides de agregar esta instancia al grupo level, para que aprezca en el nivel



func _on_VisibilityNotifier2D_screen_exited():
	queue_free(); # Decimos que si la escena enemy se encuentra fuera de la pantalla, pues que se elimine, pues puede dar el caso que se generen varios fuera de la pantalla pero no esten interactuando con el player, entonces se los elemina para que no consuman rendimiento
