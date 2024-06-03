extends State
class_name PlayerIdle

@onready var animated_sprite = $"../../AnimatedSprite2D"

func Enter():
	animated_sprite.play("Idle")

func Exit():
	pass

func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	pass
