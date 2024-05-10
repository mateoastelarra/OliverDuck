extends CharacterBody2D

signal bullet_shot(bullet_scene, location)

const SPEED = 150.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var bullet_scene = preload("res://Scenes/bullet.tscn")

@onready var animated_sprite = $AnimatedSprite2D
@onready var muzzle = $Muzzle


func _init():
	Globals.set("player", self)
	
func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()
	
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# -1 when left, 1 when right and 0 if none
	var direction = Input.get_axis("move_left", "move_right")
	 
	flip_sprite(direction)
	play_animations(direction)
	move(direction)
	move_and_slide()


func move(direction):
	if direction:
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
