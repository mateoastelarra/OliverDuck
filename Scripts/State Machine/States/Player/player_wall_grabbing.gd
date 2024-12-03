extends State
class_name PlayerWallGrabbing

@onready var player = $"../.."
@onready var player_wall_grab_timer = $"../../Timers/WallGrabTimer"
@onready var jump_buffer_timer = $"../../Timers/WallGrabJumpBufferTimer"
@export var jump_buffer_time : float = .2
var can_jump : bool = true

# Called when the node enters the scene tree for the first time.
func Enter():
	# ToDo: sprite de agarrado de pared
	if player_wall_grab_timer.is_stopped() == true:
		player_wall_grab_timer.start()
	else:
		player_wall_grab_timer.set_paused(false)
		
	jump_buffer_timer.wait_time = jump_buffer_time
	jump_buffer_timer.one_shot = true

func Exit():
	player_wall_grab_timer.set_paused(true)

func Update(_delta: float):
	pass

func jump():
	Transitioned.emit(self, "PlayerJumping")
	jump_buffer_timer.start()
	can_jump = false
	if Input.is_action_pressed("ui_right"):
		player.velocity.y = player.jump_velocity
		player.velocity.x = -player.wall_jump_pushback
	elif Input.is_action_pressed("ui_left"):
		player.velocity.y = player.jump_velocity
		player.velocity.x = player.wall_jump_pushback

func air_jump():
	Transitioned.emit(self, "PlayerJumping")
	jump_buffer_timer.start()
	can_jump = false
	if Input.is_action_pressed("ui_right"):
		player.velocity.y = player.jump_velocity
		player.velocity.x = player.wall_jump_pushback
	elif Input.is_action_pressed("ui_left"):
		player.velocity.y = player.jump_velocity
		player.velocity.x = -player.wall_jump_pushback

func Physics_Update(_delta: float):
	player.velocity.y = 0;
	if player_wall_grab_timer.time_left <= 0:
		Transitioned.emit(self, "PlayerFalling")
	
	print(player.is_on_wall())
	if can_jump and Input.is_action_just_pressed("jump"):
		jump()
	
	if not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		# el siguiente timer espera el valor del param para pasar a la siguiente linea
		await get_tree().create_timer(0.1).timeout
		if can_jump and Input.is_action_just_pressed("jump"):
			air_jump()
		Transitioned.emit(self, "PlayerFalling")
		
	if not player.is_on_wall():
		# el siguiente timer espera el valor del param para pasar a la siguiente linea
		await get_tree().create_timer(0.1).timeout
		if can_jump and Input.is_action_just_pressed("jump"):
			jump()
		Transitioned.emit(self, "PlayerFalling")

func _on_wall_grab_jump_buffer_timer_timeout():
	can_jump = true
