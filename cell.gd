extends Sprite2D

var state : bool = false
var prevState : bool = false

@export var lit : Texture
@export var unlit : Texture

func setAliveState(_state : bool):
	
	prevState = state
	state = _state
	
	if _state:
		texture = lit
	else:
		texture = unlit

func clickToggleState():
	if(!Conway.running):
		setAliveState(!state)
