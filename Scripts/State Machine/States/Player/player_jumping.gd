extends State
class_name PlayerJumping

@onready var player = $"../.."
@onready var animated_sprite = $"../../AnimatedSprite2D"
@onready var player_wall_grabbing = $"../PlayerWallGrabbing"
@export var is_wall_jump_right = false
@export var is_wall_jump_left = false

func Enter():
	animated_sprite.play("JumpSC")
	pass
	
func Exit():
	is_wall_jump_right = false
	is_wall_jump_left = false

func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	#var direction = Input.get_axis("move_left", "move_right")
	if is_wall_jump_left or is_wall_jump_right:
		#DESCOMENTAR PARA ACTIVAR WALL JUMP BUGGEADO. TAMBIEN EN player_wall_grabbing
		print("player normal.x: ")
		print(player_wall_grabbing.normal.x)
		#player.velocity.y = player.jump_velocity
		player.velocity.x = 3000 * player_wall_grabbing.normal.x #* _delta
		#if is_wall_jump_right and player.is_on_wall_only():
			#print("is wall jump right")
			#player.velocity.x = -3000
		#elif is_wall_jump_right:
			#player.velocity.x *= -_delta
			
		#if player.is_on_wall_only():
			##print("is wall jump left")
			#player.velocity.x = 3000 * -direction
		#else:
			#player.velocity.x *= _delta

	print("player velocity: ")
	print(player.velocity.x)
	player.velocity.y += player.get_gravity() * _delta
	player.velocity.y = minf(player.velocity.y, player.falling_velocity_limit)

	if player.velocity.y > 0:
		Transitioned.emit(self, "PlayerFalling")
		
	if player.is_on_wall() and !player.is_on_floor():
		if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
			Transitioned.emit(self, "PlayerWallGrabbing")
