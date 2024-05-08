extends Node2D

const SPEED = 60

var direction = 1
@onready var ray_cast_2d_right = $RayCast2DRight
@onready var ray_cast_2d_left = $RayCast2DLeft


func _process(delta):
	if ray_cast_2d_right.is_colliding():
		direction = - 1
	if ray_cast_2d_left.is_colliding():
		direction = 1
		
	position.x += direction * SPEED * delta
