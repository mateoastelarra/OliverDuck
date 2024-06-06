extends State
class_name PlayerJump

@onready var player = $"../.."
@onready var animated_sprite = $"../../AnimatedSprite2D"

func Enter():
	animated_sprite.play("Jump")

func Exit():
	pass

func Update(_delta: float):
	if player.velocity.y > 0:
		Transitioned.emit(self, "PlayerFall")
	
func Physics_Update(_delta: float):
	pass
