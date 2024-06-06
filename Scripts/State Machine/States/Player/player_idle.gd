extends State
class_name PlayerIdle

@onready var animated_sprite = $"../../AnimatedSprite2D"
@onready var player = $"../.."

func Enter():
	animated_sprite.play("Idle")

func Exit():
	pass

func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	if !player.is_on_floor():
		Transitioned.emit(self, "PlayerJump")
	elif Input.get_axis("move_left", "move_right") != 0:
		Transitioned.emit(self, "PlayerRunning")
	else:
		player.velocity = Vector2(0,0)
	
