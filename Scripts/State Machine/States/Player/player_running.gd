extends PlayerOnFloor
class_name PlayerRunning

func Enter():
	animated_sprite.play("WalkSC")

func Exit():
	pass

func Update(_delta: float):
	pass
	
	
func Physics_Update(_delta: float):
	var direction = Input.get_axis("move_left", "move_right")
	if !player.is_on_floor():
		Transitioned.emit(self, "PlayerJumping")
	elif direction == 0:
		Transitioned.emit(self, "PlayerIdle")
	
