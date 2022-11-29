extends CenterContainer

var selectable_units = preload("res://unit_selection/SelectableUnitBuilderGrid.tres")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var unitTextureRect = $TextureRect

func _process(delta):
	if Input.is_action_just_released("ui_right_button_click", false):
		selectable_units.deselect_unit()
		
func display_unit(unit):
	if unit is Unit:
		unitTextureRect.texture = unit.texture
	else:
		unitTextureRect.texture = load("res://tiles/grass and cliffs/inventory_slot.png")
	
func _gui_input(event):
	if event is InputEventMouseButton and event.is_action_released("ui_left_button_click"):
		var index = get_index()
		selectable_units.select_unit(index)

