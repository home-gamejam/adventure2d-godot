extends CharacterBody2D

class_name CharacterModel

enum CharacterStateType {
	Idle = 1,
	Move,
	Attack
}

"""
Base character state
"""
class CharacterState:
	var animation: String
	var model: CharacterModel

"""
Character idle state
"""
class IdleState extends CharacterState:
	func _init(model_: CharacterModel):
		animation = "idle"
		model = model_
		
	func update(delta: float, input: InputData) -> CharacterStateType:
		if input.direction != Vector2.ZERO:
			return CharacterStateType.Move
		
		return CharacterStateType.Idle

"""
Character move state
"""
class MoveState extends CharacterState:
	func _init(model_: CharacterModel):
		animation = "walk.down"
		model = model_
		
	func update(delta: float, input: InputData) -> CharacterStateType:
		if input.direction == Vector2.ZERO:
			model.velocity.x = move_toward(model.velocity.x, 0, model.move_speed)
			model.velocity.y = move_toward(model.velocity.y, 0, model.move_speed)
		else:
			model.velocity.x = input.direction.x * model.move_speed
			model.velocity.y = input.direction.y * model.move_speed
			print("velocity: ", model.velocity)
			
		model.move_and_slide()
		
		var suffix = "down"
		if input.direction.x < 0:
			suffix = "left"
		elif input.direction.x > 0:
			suffix = "right"
		elif input.direction.y < 0:
			suffix = "up"
			
		var prefix = "run" if input.is_running else "walk"
		
		animation = prefix + "." + suffix
		
		if model.velocity.length() < .1:
			return CharacterStateType.Idle
		
		return CharacterStateType.Move

"""
Character attack state
"""
class AttackState extends CharacterState:
	func _init(model_: CharacterModel):
		animation = "attack"
		model = model_
		
	func update(delta: float, input: InputData) -> CharacterStateType:
		return CharacterStateType.Attack

"""
Character model members
"""

@onready var animation_player = $AnimationPlayer as AnimationPlayer
@export var walk_speed: float = 300.0

var move_speed = walk_speed
var current_animation: String = ""
var current_state_type = CharacterStateType.Idle
var states: Dictionary[CharacterStateType, CharacterState] = {
	CharacterStateType.Idle: IdleState.new(self),
	CharacterStateType.Move: MoveState.new(self),
	CharacterStateType.Attack: MoveState.new(self)
}

var current_state: CharacterState:
	get():
		return states[current_state_type]

func update(delta: float, input: InputData) -> void:	
	var next_state_type = current_state.update(delta, input)
	var next_animation = current_state.animation
	if next_state_type == current_state_type and next_animation == current_animation:
		return
	
	current_animation = next_animation
	current_state_type = next_state_type
	animation_player.stop()
	animation_player.play(current_state.animation)
