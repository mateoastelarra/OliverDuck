extends Area2D

@onready var animation_player = $"../AnimationPlayer"

func _on_body_entered(body):
	animation_player.play("Move")
	print("Movete plataforma")
	queue_free()
