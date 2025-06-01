extends InputSource

class_name PlayerInputSource

func get_input() -> InputData:
	var input_data = InputData.new()
	input_data.direction = Input.get_vector("left", "right", "up", "down", .1)
	input_data.is_attacking = Input.is_action_just_pressed("actionb")
	input_data.is_running = Input.is_action_pressed("actionb")
	return input_data
