class_name InputData

# static func from_input():
# 	var input_data = InputData.new()
# 	input_data.direction = Input.get_vector("left", "right", "up", "down", .1)
# 	input_data.is_attacking = Input.is_action_just_pressed("actionb")
# 	input_data.is_running = Input.is_action_pressed("actionb")

var direction: Vector2 = Vector2.ZERO
var is_attacking: bool = false
var is_running: bool = false
