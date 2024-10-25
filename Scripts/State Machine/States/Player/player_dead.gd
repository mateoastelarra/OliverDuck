extends State
class_name PlayerDead


@onready var player = $"../.."
@onready var animated_sprite = $"../../AnimatedSprite2D"

func Enter():
	animated_sprite.play("DieP")

func Exit():
	pass

func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	pass
