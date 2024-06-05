extends CharacterBody2D

signal bullet_shot(bullet_scene, location)

const SPEED = 150.0
const JUMP_VELOCITY = -300.0

@export var gravity: float = 980
@export var falling_velocity_limit: float = 400
@export var gliding_ratio: float = 0.1
@export var gliding_time: float = 1

var bullet_scene = preload("res://Scenes/bullet.tscn")
var looking_direction
var is_gliding: bool = false

@onready var animated_sprite = $AnimatedSprite2D
@onready var muzzle = $Muzzle
@onready var gliding_timer = $GlidingTimer


func _init():
	Globals.set("player", self)


func _ready():
	gliding_timer.wait_time = gliding_time
	gliding_timer.one_shot = true
	
		
func _process(delta):
	if Input.is_action_pressed("shoot"):
		shoot()
	
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		handle_gravity(delta)
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY	
		
	# -1 when left, 1 when right and 0 if none
	var direction = Input.get_axis("move_left", "move_right")
	
	move(direction)
	manage_glide()
	flip_sprite(direction)
	update_shooting_direction()
	#play_animations(direction)
	move_and_slide()


func move(direction):
	if direction and !Input.is_action_pressed("dont_move"):
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		

func play_animations(direction):
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("Run")
	else:
		animated_sprite.play("Jump")
		

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
		

func handle_gravity(delta):
	if is_gliding and velocity.y > 0:
		velocity.y = gliding_ratio
	else:
		velocity.y += gravity * delta
		velocity.y = minf(velocity.y, falling_velocity_limit)

func manage_glide():
	if Input.is_action_just_pressed("glide") and !is_on_floor():
		glide()
	
	if Input.is_action_just_released("glide") or is_on_floor():
		is_gliding = false
	
func glide():
	if !is_gliding:
		is_gliding = true
		gliding_timer.start()
	
	
func _on_gliding_timer_timeout():
	is_gliding = false
