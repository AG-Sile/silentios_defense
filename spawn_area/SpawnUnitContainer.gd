extends CenterContainer

var selectable_units = preload("res://unit_selection/SelectableUnitBuilderGrid.tres")

func set_green():
	var red_node = get_node("RedSquare")
	var green_node = get_node("GreenSquare")		
	red_node.visible = false
	green_node.visible = true
	
func set_red():
	var red_node = get_node("RedSquare")
	var green_node = get_node("GreenSquare")		
	red_node.visible = true
	green_node.visible = false

func set_no_color():
	var red_node = get_node("RedSquare")
	var green_node = get_node("GreenSquare")		
	red_node.visible = false
	green_node.visible = false

func _on_SpawnUnitContainer_mouse_entered():
	if selectable_units.selected_unit is Unit:
		set_red()


func _on_SpawnUnitContainer_mouse_exited():
	set_no_color()  # Replace with function body.
