extends Node2D
class_name Enemy
const SPEED = 60

var direction = 1
@onready var ray_cast_right = $RayCast2DRight
@onready var ray_cast_left = $RayCast2DLeft
@onready var animated_sprite = $AnimatedSprite2D

@export var health_component : HealthComponent

func _process(delta):
	if ray_cast_right.is_colliding():
		direction = - 1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
		
	position.x += direction * SPEED * delta


func damage(damage: int):
	if health_component:
		print("damage")
		health_component.take_damage(damage)

