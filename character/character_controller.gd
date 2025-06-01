extends Node2D

class_name CharacterController

@export var input_source: InputSource
@export var model: CharacterModel
@export var view: Node2D

func _physics_process(delta: float) -> void:
	var input = input_source.get_input()
	model.update(delta, input)
	view.position = model.position
 
