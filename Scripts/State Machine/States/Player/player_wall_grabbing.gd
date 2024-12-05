extends State
class_name PlayerWallGrabbing

@onready var player = $"../.."
@onready var player_wall_grab_timer = $"../../Timers/WallGrabTimer"
@onready var player_jumping = $"../PlayerJumping"
@export var normal = 0

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
	
#DESCOMENTAR PARA ACTIVAR WALL JUMP BUGGEADO. TAMBIEN EN player_jumping
	#if Input.is_action_just_pressed("jump") and player.input.x == 0:
		#var collision = player.get_last_slide_collision()
		#normal = collision.get_normal()
#
		## Check if the normal vector is true and if it points left or right
		#if normal: 
			##player.velocity.y = player.jump_velocity
			#if normal.x < 0:  # Wall is to the right
				#player_jumping.is_wall_jump_right = true
			#elif normal.x > 0:  # Wall is to the left
				#player_jumping.is_wall_jump_left = true
		#player.jump()
		#Transitioned.emit(self, "PlayerJumping")
	
	if not player.is_on_wall():
		Transitioned.emit(self, "PlayerFalling")
	
	if not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		Transitioned.emit(self, "PlayerFalling")
