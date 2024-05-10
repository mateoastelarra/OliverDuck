extends Area2D

@export var speed = 100
	
	
func _physics_process(delta):
	global_position.x += speed * delta
	print(global_position.x)


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
