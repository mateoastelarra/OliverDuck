extends CharacterBody2D

signal bullet_shot(bullet_scene, location)

const MAX_SPEED = 200
const ACCELERATION = 1000
const FRICTION = 1200
const SPEED = 150.0
const JUMP_VELOCITY = -300.0

@export var gravity: float = 980
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
		velocity.y = JUMP_VELOCITY	
		
	# -1 when left, 1 when right and 0 if none
	var direction = Input.get_axis("move_left", "move_right")
	
	#move(direction)
	player_movement(direction, delta)
	flip_sprite(direction)
	update_shooting_direction()
	

func get_input():
	input = Input.get_axis("move_left", "move_right")

func player_movement(direction, delta):
	if direction == 0:
		if abs(velocity.x) >  FRICTION * delta:
			velocity.x -= sign(velocity.x) * FRICTION * delta
		else:
			velocity.x = 0
	else:
		velocity.x += direction * ACCELERATION * delta
		velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
	print(velocity.x)
	move_and_slide()
	
func move(direction):
	if direction and !Input.is_action_pressed("dont_move"):
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		

func flip_sprite(direction):
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true


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
