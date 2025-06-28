extends Node

class_name CharacterController

@export var input_source: InputSource
@export var model: CharacterModel
@export var view: CharacterView

func _physics_process(delta: float) -> void:
	var prev_animation = model.animation
	var prev_animation_direction = model.animation_direction

	var input = input_source.get_input()
	model.update(input, delta)

	var animation_changed = prev_animation != model.animation or prev_animation_direction != model.animation_direction
	if animation_changed:
		view.play(model.animation + "." + str(model.animation_direction))
