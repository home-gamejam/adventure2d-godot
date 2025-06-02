@tool
extends AnimatedSprite2D

class_name CharacterView

@export var texture: Texture
@export var frame_duration: float = .2
@export var frame_size: int = 128

func _ready():
	sprite_frames = SpriteFrames.new()
	sprite_frames.remove_animation("default")

	# Setup idle animations for 8 directions
	for dir_i in range(8):
		var animation_name = "idle." + str(dir_i)
		sprite_frames.add_animation(animation_name)

		var atlas_texture = AtlasTexture.new()
		atlas_texture.atlas = texture
		atlas_texture.region = Rect2(0, frame_size * dir_i, frame_size, frame_size)
		sprite_frames.add_frame(animation_name, atlas_texture, frame_duration)

	# Setup walk animations for 8 directions
	for dir_i in range(8):
		var animation_name = "walk." + str(dir_i)
		sprite_frames.add_animation(animation_name)

		# 8 frames in each direction
		for frame_i in range(8):
			var atlas_texture = AtlasTexture.new()
			atlas_texture.atlas = texture
			atlas_texture.region = Rect2(frame_size * frame_i, frame_size * dir_i, frame_size, frame_size)
			sprite_frames.add_frame(animation_name, atlas_texture, frame_duration)
