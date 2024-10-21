extends State
class_name PlayerWallGrabbing

@onready var animated_sprite = $"../../AnimatedSprite2D" 
@onready var player = $"../.."
@onready var wall_grab_timer = $Timers/WallGrabTimer
@export var wall_grab_time : float = 4.

func Enter():
	animated_sprite.play("JumpSC") # ToDo: tener sprite para wall grab
	wall_grab_timer.wait_time = wall_grab_time
	wall_grab_timer.one_shot = true
	wall_grab_timer.start()
	
func Exit():
	pass

func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	if !player.is_on_floor():
		Transitioned.emit(self, "PlayerJumping")
	elif Input.get_axis("move_left", "move_right") != 0:
		Transitioned.emit(self, "PlayerRunning")
	elif Input.is_action_just_pressed("kiss"):
		Transitioned.emit(self, "PlayerKiss")
	
