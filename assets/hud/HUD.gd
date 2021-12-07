extends CanvasLayer

signal game_over; # Sirve para crear una señal, esta señal aparecera en el arbol de señales. Utilizamos la palabra reservada 'signal' para crearla


func _ready():
	GLOBAL.score =0;


func _physics_process(delta): # Recuerda que es esta funcion se ejecuta automaticamente en cada fotograma, es decir que se actualiza
	$MarginContainer/HBoxContainer/score.text = str(GLOBAL.score); # Accedemos al 'label' score, y le ponemos el metodo 'text', para insertar texto. Luego le decimos que ese texto va a ser igual a GLOBAL.score, para acceder a la variable 'score', que establecimos en GLOBAL.gd. No te olvides de pasarlo a 'String', con el metofo 'str()'.

	
func game_over():
	emit_signal("game_over"); # Funcion para emitir una señal, en este caso, emitimos la señal 'game_over' que creamos
	$AudioStreamPlayer.play();
	$GAMEOVER.visible = true;

func _on_restart_pressed():
	#Forma corta (Tira advertencias)
	#get_tree.reload_current_scene();
	#Forma larga
	get_tree().call_deferred("reload_current_scene"); #Recargamos la escena actual, accediendo al arbol de escenas y haciendo una llamada segura


func _on_menu_pressed(): # Funcion generada al asignarle una señal al boton "Menu", especificamente 'pressed()'
	#get_tree().change_scene("res://assets/menu/Menu.tscn");
	get_tree().call_deferred("change_scene","res://assets/menu/Menu.tscn"); #Hacemos lo mismo que en el boton restart. Cuando se presione este boton, se accedera a la escena "menu.tscn", por eso le ponemos su ruta. No te olvides de añádir el metodo 'change_scene'


func _on_KinematicBody2D_tree_exiting(): # Señal que sirve para avisar cuando un nodo se ha salido de su arbol de escenas, en este caso, como se lo hemos aplicado al palyer, seria cuando el player sea destruido
	game_over();
		
