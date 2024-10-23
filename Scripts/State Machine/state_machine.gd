extends Node
class_name StateMachine

@export var initial_state: State
var current_state: State
var states: Dictionary = {}
@onready var player = $".."

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	
	if initial_state:
		initial_state.Enter()
		current_state = initial_state
		
func _process(delta):
	if current_state:
		current_state.Update(delta)
		
func _physics_process(delta):
	if current_state:
		current_state.Physics_Update(delta)
		
		# ToDo deuda técnica: ver si poniendo condiciones acá, se cambia de estado sin importar
		# en cuál estado se está actualmente. (Para evitar código duplicado)
	if player.is_on_wall() and !player.is_on_floor():
		if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
			print("dentro del if")
			current_state.Transitioned.emit(self, "PlayerWallGrabbing")

func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.Exit()
	
	new_state.Enter()
	current_state = new_state

