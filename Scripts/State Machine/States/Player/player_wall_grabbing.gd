extends State
class_name PlayerWallGrabbing

@onready var player = $"../.."
@onready var player_wall_grab_timer = $"../../Timers/WallGrabTimer"
@onready var animated_sprite = $"../../AnimatedSprite2D"
@onready var player_jumping = $"../PlayerJumping"
@export var normal = 0

@export var wall_jump_pushback = 1200
@export var wall_jump_velocity : float = (-3.0 * 30.) / 0.5

func Enter():
	animated_sprite.play("WallGrab")
	if player_wall_grab_timer.is_stopped() == true:
		player_wall_grab_timer.start()
	else:
		player_wall_grab_timer.set_paused(false)
		
	var collision = player.get_last_slide_collision()
	normal = collision.get_normal()

func Exit():
	player_wall_grab_timer.set_paused(true)

func Update(_delta: float):
	pass
	
func wall_jump() -> void:
	player.velocity.y = wall_jump_velocity
	player.velocity.x = normal.x * wall_jump_pushback
	player.jump_available = false

func Physics_Update(_delta: float):
	player.velocity.y = 0;
	if player_wall_grab_timer.time_left <= 0:
		Transitioned.emit(self, "PlayerFalling")
	
	if Input.is_action_just_pressed("jump") and player.input.x == 0:
		# Check if the normal vector is true and if it points left or right
		if normal: 
			#player.velocity.y = player.jump_velocity
			if normal.x < 0:  # Wall is to the right
				player_jumping.is_wall_jump_right = true
			elif normal.x > 0:  # Wall is to the left
				player_jumping.is_wall_jump_left = true
			wall_jump()
			Transitioned.emit(self, "PlayerJumping")
	
	if not player.is_on_wall():
		Transitioned.emit(self, "PlayerFalling")
	
	if not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		Transitioned.emit(self, "PlayerFalling")
