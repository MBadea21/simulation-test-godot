extends Node2D

const row_count : int = 20
const column_count : int = 40
const cell_width: int = 15

var cell_matrix : Array = [] # Empty Array which contains all columns

func generate():
	
	var rng = RandomNumberGenerator.new()
	
	cell_matrix = []
	
	for column in range(column_count):
		cell_matrix.push_back([])
		for row in range(row_count):
			var cell = true if (rng.randi_range(0,1) == 1) else false
			cell_matrix[column].push_back(cell)
			
	

func _ready():
	
	# Generate setup
	generate()
	
	# Test array is populated
	
	
	
func getValidIndex(count: int, index : int):
	var valid = range(count)
	
	if index not in valid:
		# If it's smaller than the front, then loop to thte back
		if(index < valid.front()):
			return valid.back()
		# If it's not smaller than the front, then it must be bigger, no need to check
		# Loop to the back
		return valid.front()
		
	# If it is in valid, then 
	return index
	
	
func _process(delta):
	var timer = 0
	const limit = 5 # seconds
	
	timer+= delta
	
	if(timer > limit):
		pass
		# run simulation step
	
	# For each cell, check all it's neighbours, add the amount of alive or dead, update status
	
	
	# TODO Add image texture integration to create an image texture with the setup
	
	pass
	
