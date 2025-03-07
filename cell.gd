extends Sprite2D

var state : bool = false
var nextState : bool

@export var lit : Texture
@export var unlit : Texture

var gridPos : Vector2i

func setAliveState(_state : bool, init : bool = false):
	if(init):
		state = _state
		
	nextState = _state

func update():
	state = nextState
	
	if state:
		texture = lit
	else:
		texture = unlit

func clickToggleState():
	if(!Conway.running):
		setAliveState(!state)
		update()
		

func printNeighbourStates():
	print(Conway.countNeighbours(gridPos.x, gridPos.y))
	#Conway.countNeighbours(gridPos.x,gridPos.y)
