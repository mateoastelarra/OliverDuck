extends State
class_name PlayerWallGrabbing

@onready var player = $"../.."
@onready var player_wall_grab_timer = $"../../Timers/WallGrabTimer"

# Called when the node enters the scene tree for the first time.
func Enter():
	# ToDo: sprite de agarrado de pared
	if player_wall_grab_timer.is_stopped() == true:
		player_wall_grab_timer.start()
	else:
		player_wall_grab_timer.set_paused(false)

func Exit():
	player_wall_grab_timer.set_paused(true)

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	player.velocity.y = 0;
	if player_wall_grab_timer.time_left <= 0:
		Transitioned.emit(self, "PlayerFalling")
	
	if Input.is_action_just_pressed("jump"):
		if Input.is_action_pressed("ui_right"):
			player.velocity.y = player.jump_velocity
			player.velocity.x = -player.wall_jump_pushback
		elif Input.is_action_pressed("ui_left"):
			player.velocity.y = player.jump_velocity
			player.velocity.x = player.wall_jump_pushback
		Transitioned.emit(self, "PlayerJumping")
	
	if not Input.is_action_pressed("ui_left") or not Input.is_action_pressed("ui_right"):
		Transitioned.emit(self, "PlayerFalling")
	
	
