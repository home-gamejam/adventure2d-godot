extends CharacterBody2D

class_name CharacterModel

enum AnimationDirection {
	S = 0,
	SW,
	W,
	NW,
	N,
	NE,
	E,
	SE
}

enum CharacterStateType {
	Idle = 1,
	Move,
	Attack
}

"""
Character model members
"""

@export var walk_speed: float = 300.0

var move_speed = walk_speed

var animation: String = ""
var animation_direction: AnimationDirection = AnimationDirection.S
var state_type = CharacterStateType.Idle

"""
Update character state
"""
func update(input: InputData, delta: float) -> void:
	match state_type:
		CharacterStateType.Idle:
			_update_idle(input, delta)
		CharacterStateType.Move:
			_update_move(input, delta)
		CharacterStateType.Attack:
			_update_attack(input, delta)


"""
Update idle state
"""
func _update_idle(input: InputData, _delta: float) -> void:
	animation = "idle"

	if input.direction != Vector2.ZERO:
		state_type = CharacterStateType.Move


"""
Update move state
"""
func _update_move(input: InputData, _delta: float) -> void:
	animation = "run" if input.is_running else "walk"

	if input.direction == Vector2.ZERO:
		move_speed = walk_speed
		velocity.x = move_toward(velocity.x, 0, move_speed)
		velocity.y = move_toward(velocity.y, 0, move_speed)

		move_and_slide()

		if velocity.length() < .1:
			state_type = CharacterStateType.Idle
	else:
		move_speed = walk_speed * (2 if input.is_running else 1)
		velocity.x = input.direction.x * move_speed
		velocity.y = input.direction.y * move_speed

		if input.direction.x < 0:
			animation_direction = AnimationDirection.W
		elif input.direction.x > 0:
			animation_direction = AnimationDirection.E
		elif input.direction.y < 0:
			animation_direction = AnimationDirection.N
		else:
			animation_direction = AnimationDirection.S

		move_and_slide()


"""
Update attack state
"""
func _update_attack(_input: InputData, _delta: float) -> void:
	pass
