extends State
class_name PlayerFalling

@onready var player = $"../.."
@onready var animated_sprite = $"../../AnimatedSprite2D"

func Enter():
	animated_sprite.play("Jump")

func Exit():
	pass

func Update(_delta: float):
	if player.is_on_floor():
		Transitioned.emit(self, "PlayerIdle")
	
func Physics_Update(_delta: float):
	pass
