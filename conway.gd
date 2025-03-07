extends Node2D

var cellArray = []

const rows = 18
const columns = 32

const cell_width = 27

var cell_scene = preload("res://cell.tscn")

var rng = RandomNumberGenerator.new()


func createGrid():
	for row in range(rows):
		cellArray.push_back([])
		for column in range(columns):
			var cell_node = cell_scene.instantiate()
			self.add_child(cell_node)
			cellArray[row].push_back(cell_node)
			cell_node.position = self.position + Vector2(
				cell_width * column,
				cell_width * row
			)
			cell_node.gridPos = Vector2i(row,column)
			# Set starting state:
			
			# Set to random starting state
			#cell_node.setAliveState(rng.randi_range(0,1), true)
			
			
			cell_node.setAliveState(false, true)
			

func _ready() -> void:
	# Offset position
	position += Vector2(30,30)
	
	# Initialize grid
	createGrid()

	# Set text visibility
	var pause_text = get_node("/root/Scene/UI/PauseText")
	pause_text.visible = running

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

func getNeighbourState(row, column):
	
	var neighbour = cellArray[wrap_index(rows,row)][wrap_index(columns,column)]
	return neighbour.state
	

func countNeighbours(row, column) -> int:
	# Look at each neighbour, where prev state = alive
	var up_left = getNeighbourState(row-1,column-1)
	var up = getNeighbourState(row-1,column)
	var up_right = getNeighbourState(row-1,column+1)
	
	var left = getNeighbourState(row,column-1)
	var right = getNeighbourState(row,column+1)
	
	var down_left = getNeighbourState(row+1,column-1)
	var down = getNeighbourState(row+1,column)
	var down_right = getNeighbourState(row+1,column+1)
	
	var neighbours = [up_left, up, up_right, left, right, down_left, down, down_right]
	
	var aliveNeighbours = 0
	
	for n in neighbours:
		if n:
			aliveNeighbours += 1
	
	return aliveNeighbours

func runSimulationStep():
	
	# Set up next states
	
	for row in range(rows):
		for column in range(columns):
			
			var n = countNeighbours(row, column)
			
			# Update on new state based on number
			if(cellArray[row][column].state == false):
				if(n == 3):
					cellArray[row][column].setAliveState(true)
				else:
					cellArray[row][column].setAliveState(false)
					
			else:
				if(n <= 1 or n >= 4):
					cellArray[row][column].setAliveState(false)
				else:
					cellArray[row][column].setAliveState(true)
		
	# States set up, now go through and update all
	for row in range(rows):
		for column in range(columns):
			cellArray[row][column].update()


var running = false
var timer = 0
var processDelay = 1.0

func _input(event):
	if event.is_action_pressed("ui_accept"):
		
		running = !running
			
		print("Running:",running)
		var pause_text = get_node("/root/Scene/UI/PauseText")
		pause_text.visible = running
		
	if event.is_action_pressed("ui_up"):
		processDelay = processDelay / 2
		print("Process delay updated to:", processDelay)
		
	if event.is_action_pressed("ui_down"):
		processDelay = processDelay * 2
		print("Process delay updated to:", processDelay)

func _process(delta: float) -> void:
	if running:
		timer += delta
	
	if (timer > processDelay):
		timer = 0
		runSimulationStep()
