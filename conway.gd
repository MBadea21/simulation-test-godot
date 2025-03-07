extends Node2D

var cellArray = []

var rows = 32
var columns = 18
var cell_width = 27

var cell_scene = preload("res://cell.tscn")

var rng = RandomNumberGenerator.new()


func createGrid():
	for row in range(rows):
		for column in range(columns):
			var cell_node = cell_scene.instantiate()
			self.add_child(cell_node)
			cell_node.position = self.position + Vector2(
				cell_width * row,
				cell_width * column
			)
			# Set starting state:
			
			# Set to random starting state
			var startState = cell_node.setAliveState(rng.randi_range(0,1))
			
	
	

func _ready() -> void:
	# Offset position
	position += Vector2(30,30)
	
	# Initialize grid
	createGrid()

	# Set text visibility
	var pause_text = get_node("/root/Scene/UI/PauseText")
	pause_text.visible = running



func runSimulationStep():
	
	pass


var running = false
var timer = 0
const processDelay = 1

func _input(event):
	if event.is_action_pressed("ui_accept"):
		
		running = !running
			
		print("Running:",running)
		var pause_text = get_node("/root/Scene/UI/PauseText")
		pause_text.visible = running

func _process(delta: float) -> void:
	if running:
		timer += delta
	
	if (timer > processDelay):
		timer = 0
		runSimulationStep()
