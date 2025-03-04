extends Sprite2D

var data_size = Vector2i(100, 100) # Define the size of your boolean array
var bool_array = []  # Your array of arrays of bools
var output_texture

const iterationDelay = 1
var timer = 0.0

func bool_array_to_texture(array):
	var width = array.size()
	var height = array[0].size()
	
	var image = Image.create(width, height, false, Image.FORMAT_L8)  # Grayscale 8-bit image
	for y in range(height):
		for x in range(width):
			var value = 1.0 if array[x][y] else 0.0  # Convert bool to 0 or 1
			image.set_pixel(x, y, Color(value, value, value))
	
	var img_texture = ImageTexture.create_from_image(image)
	return img_texture

func save_image(image: ImageTexture, path: String):
	pass
	image.get_image().save_png(path)


func _ready():
	
	var rng = RandomNumberGenerator.new()
	
	# Initialize a test pattern of booleans (modify according to your needs)
	for y in range(data_size.y):
		var row = []
		for x in range(data_size.x):
			row.append(true if (rng.randi_range(0,1) == 1) else false)  # Example pattern (checkerboard)
		bool_array.append(row)
	
	
	## Convert the bool array to a texture
	output_texture = bool_array_to_texture(bool_array)
	
	var path = "user://test_output.png"
	save_image(output_texture,path)
	#
	## Set the texture to the Sprite2D
	set_texture(output_texture)
	#
	## Asign texture to shader
	#var shader_material = ShaderMaterial.new()
	#shader_material.shader = preload("res://conway_display.gdshader")
	#shader_material.set_shader_parameter("tex", output_texture)
	##
	#set_material(shader_material)
	
func wrap_index(maxCount: int, index : int):
	var valid = range(maxCount)
	
	if index not in valid:
		# If it's smaller than the front, then loop to thte back
		if(index < valid.front()):
			return valid.back()
		# If it's not smaller than the front, then it must be bigger, no need to check
		# Loop to the back
		return valid.front()
		
	# If it is in valid, then 
	return index
	
	
func run_iteration():
	
	pass

func _process(delta: float) -> void:
	
	
	timer += delta

	if(timer > iterationDelay):
		run_iteration()
		timer = 0
	
	
