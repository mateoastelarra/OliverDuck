extends Node2D
class_name HealthComponent

signal no_longer_evil

@export var max_health := 3
var health: int


func _ready():
	health = max_health


func take_damage(damage: int):
	health -= damage
	if health <= 0:
		no_longer_evil.emit()
	
