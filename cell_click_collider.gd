extends Area2D

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		
		if event.button_index == MOUSE_BUTTON_LEFT:
			get_parent().clickToggleState()
			
		if event.button_index == MOUSE_BUTTON_RIGHT:
			get_parent().printNeighbourStates()
	
