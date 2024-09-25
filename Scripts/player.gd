extends CharacterBody2D

signal bullet_shot(bullet_scene, location)

# Movement
@export var max_speed = 200
@export var acceleration = 1000
@export var friction = 1200
@export var wall_jump_pushback = 1200
@export var wall_slide_gravity = 0

# Jump
@export var jump_height : float = 125
@export var jump_time_to_peak : float = 0.6
@export var jump_time_to_descend : float = 0.5
@export var jump_velocity : float = (-2.0 * jump_height) / jump_time_to_peak
@export var jump_gravity : float = (2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)
@export var fall_gravity : float = (2.0 * jump_height) / (jump_time_to_descend * jump_time_to_descend)
#@export var gravity: float = 980
@export var falling_velocity_limit: float = 400
@export var jump_buffer_time : float = .1
#@export var coyote_time : float = .1

var input = Vector2.ZERO
var bullet_scene = preload("res://Scenes/bullet.tscn")
var looking_direction
var has_glided : bool = false
#var jump_available : bool = true
#var jump_buffer : bool = false
var kiss_finished : bool = true
var is_wall_sliding = false

@onready var animated_sprite = $AnimatedSprite2D
@onready var muzzle = $Muzzle
#@onready var jump_buffer_timer = $StateMachine/PlayerOnFloor/JumpBufferTimer
@onready var coyote_timer = $StateMachine/PlayerOnFloor/CoyoteTimer

func _init():
	Globals.set("player", self)

#func _ready():
	#jump_buffer_timer.wait_time = jump_buffer_time
	#jump_buffer_timer.one_shot = true	
	#coyote_timer.wait_time = coyote_time
		
#func _process(delta):
	#pass
	
	
func _physics_process(delta):	
	# don´t move if kissing
	if !kiss_finished:
		move_and_slide()
		return
	
	## Handle jump.
	#if Input.is_action_just_pressed("jump"):
		#if is_on_wall() and !is_on_floor():
			#wall_jump()
		#elif jump_available:
			#jump()
		#else:
			#jump_buffer = true
			#jump_buffer_timer.start()
		#
	#if not is_on_floor():
		#if jump_available:
			#if coyote_timer.is_stopped():
				#coyote_timer.start()
		#velocity.y += get_gravity() * delta
	#else:
		#jump_available = true
		#coyote_timer.stop()
		#if jump_buffer:
			#jump()
			#jump_buffer = false
		
	
	# -1 when left, 1 when right and 0 if none
	var direction = Input.get_axis("move_left", "move_right")
	
	player_movement(direction, delta)
	flip_sprite(direction)
	update_shooting_direction()
	wall_slide(delta)
	

func get_input():
	input = Input.get_axis("move_left", "move_right")

func player_movement(direction, delta):
	if direction == 0:
		if abs(velocity.x) >  friction * delta:
			velocity.x -= sign(velocity.x) * friction * delta
		else:
			velocity.x = 0
	else:
		velocity.x += direction * acceleration * delta
		velocity.x = clamp(velocity.x, -max_speed, max_speed)
	move_and_slide()
		

func flip_sprite(direction):
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

func get_gravity() -> float:
	if is_on_wall_only() and (Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left")):
		return wall_slide_gravity
	if velocity.y < 0.0:
		return jump_gravity
	else:
		return fall_gravity

#func jump() -> void:
	#velocity.y = jump_velocity
	#jump_available = false
	
func wall_jump() -> void:
	if Input.is_action_pressed("ui_right"):
		velocity.y = jump_velocity
		velocity.x = -wall_jump_pushback
	elif Input.is_action_pressed("ui_left"):
		velocity.y = jump_velocity
		velocity.x = wall_jump_pushback
	
func shoot():
	bullet_shot.emit(bullet_scene, muzzle.global_position)

func wall_slide(delta):
	if is_on_wall() and !is_on_floor():
		if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
			is_wall_sliding = true
		else:
			is_wall_sliding = false
	else:
		is_wall_sliding = false
		
	if is_wall_sliding:
		#velocity.y += (wall_slide_gravity * delta)
		#velocity.y = min(velocity.y, wall_slide_gravity)
		velocity.y = 0

func update_shooting_direction():
	var current_direction : Vector2 = Input.get_vector(
											"aim_left", 
											"aim_right", 
											"aim_up", 
											"aim_down")
	if current_direction != Vector2.ZERO:
		looking_direction = current_direction
	elif animated_sprite.flip_h:
		looking_direction = Vector2(-1,0)
	else:
		looking_direction = Vector2(1,0)
