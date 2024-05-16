extends Area2D
class_name Killzone

@onready var timer = $Timer
var is_evil: bool

func _ready():
	is_evil = true
	
	
func _on_body_entered(body):
	if is_evil:
		print("You Died.")
		Engine.time_scale = 0.5
		body.get_node("CollisionShape2D").queue_free()
		
		timer.start()


func _on_timer_timeout():
	Engine.time_scale = 1
	get_tree().reload_current_scene()


func _on_health_component_no_longer_evil():
	is_evil = false
