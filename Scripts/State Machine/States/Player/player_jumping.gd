extends State
class_name PlayerJumping

@onready var player = $"../.."
@onready var animated_sprite = $"../../AnimatedSprite2D"
@onready var player_wall_grabbing = $"../PlayerWallGrabbing"
@onready var apply_gravity_timer = $"../../Timers/ApplyGravityTimer"
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
	if is_wall_jump_left or is_wall_jump_right:
		if apply_gravity_timer.is_stopped():
			apply_gravity_timer.start()
		if apply_gravity_timer.time_left <= 0.1:
			is_wall_jump_left = false
			is_wall_jump_right = false
	else:
		player.velocity.y += player.get_gravity() * _delta
		player.velocity.y = minf(player.velocity.y, player.falling_velocity_limit)
		
	#print("player velocity: ")
	#print(player.velocity.x)

	if player.velocity.y > 0:
		Transitioned.emit(self, "PlayerFalling")
		
	if player.is_on_wall() and !player.is_on_floor():
		if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
			Transitioned.emit(self, "PlayerWallGrabbing")
