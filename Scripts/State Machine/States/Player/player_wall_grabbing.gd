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
	print("PlayerWallGrabbing")
	player.velocity.y = 0;
	print( player_wall_grab_timer.time_left)
	if player_wall_grab_timer.time_left <= 0:
		Transitioned.emit(self, "PlayerFalling")
		#player.velocity.y += (player.wall_slide_gravity * _delta)
		#player.velocity.y = min(player.velocity.y, player.wall_slide_gravity)
		#can_wall_grab = false
	
	if Input.is_action_just_pressed("jump"):
		Transitioned.emit(self, "PlayerJumping")
	
	if not Input.is_action_pressed("ui_left") or not Input.is_action_pressed("ui_right"):
		Transitioned.emit(self, "PlayerFalling")
	
	
