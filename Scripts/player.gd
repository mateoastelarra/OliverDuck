extends CharacterBody2D

signal bullet_shot(bullet_scene, location)

# Movement
@export var max_speed = 200
@export var acceleration = 1000
@export var friction = 1200

# Jump
@export var jump_height : float = 135
@export var jump_time_to_peak : float = 0.6
@export var jump_time_to_descend : float = 0.5


@export var jump_velocity : float = (-2.0 * jump_height) / jump_time_to_peak
@export var jump_gravity : float = (2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)
@export var fall_gravity: float = (2.0 * jump_height) / (jump_time_to_descend * jump_time_to_descend)
#@export var gravity: float = 980
@export var falling_velocity_limit: float = 400

var input = Vector2.ZERO
var bullet_scene = preload("res://Scenes/bullet.tscn")
var looking_direction
var has_glided: bool = false

@onready var animated_sprite = $AnimatedSprite2D
@onready var muzzle = $Muzzle

func _init():
	Globals.set("player", self)
	
		
func _process(delta):
	if Input.is_action_pressed("shoot"):
		shoot()
	
	
func _physics_process(delta):	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	if !is_on_floor():
		velocity.y += get_gravity() * delta
	
	# -1 when left, 1 when right and 0 if none
	var direction = Input.get_axis("move_left", "move_right")
	
	player_movement(direction, delta)
	flip_sprite(direction)
	update_shooting_direction()
	

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
	if velocity.y < 0.0:
		return jump_gravity
	else:
		return fall_gravity

func shoot():
	bullet_shot.emit(bullet_scene, muzzle.global_position)


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
