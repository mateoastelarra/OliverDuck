extends Area2D

@export var speed = 100

var direction = Vector2(1, 0)
	
func _physics_process(delta):
	global_position += speed * delta * direction


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
