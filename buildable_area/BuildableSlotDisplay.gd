extends CenterContainer

var buildable = preload("res://buildable_area/buildable_grid.tres")
var selectable_units = preload("res://unit_selection/SelectableUnitBuilderGrid.tres")
onready var unitTextureRect = $Sprite
onready var unitSpawnNode = $Unit

func display_unit(unit):
	if unit is Unit:
		var unit_scene = unit.unit_scene
		var unit_instance = unit_scene.instance()
		var main = get_tree().current_scene
		var spawnable_unit_node = main.get_node("BuildableUnits")
		var index = get_index() 
		var spawn_area_container = spawnable_unit_node.get_child(index)
		spawn_area_container.spawn_unit(unit_scene, index)	
	#for enemy_number in wave_enemies_info["number_of_units"]:
	#	var spawn_area_container = spawnable_unit_node.get_child(enemy_number)
	#	spawn_area_container.spawn_enemy(wave_enemies_info["unit"], enemy_number)

	else:
		unitTextureRect.texture = load("res://tiles/grass and cliffs/tile182.png")

func _gui_input(event):
	var index = get_index()
	var is_left_button_click = event is InputEventMouseButton and event.is_action_released("ui_left_button_click")
	var wave_in_progress = GameManager.wave_in_progress
	var can_build = buildable.units[index] == null and wave_in_progress == false 
	if is_left_button_click and selectable_units.selected_unit is Unit and can_build:
		var unit_gold_cost = selectable_units.selected_unit.gold_cost
		buildable.units[index] = selectable_units.selected_unit
		display_unit(selectable_units.selected_unit)
		GameManager.gold -= unit_gold_cost
		selectable_units.deselect_unit()
		set_no_color()
	if  event is InputEventMouseButton and event.is_action_released("ui_right_button_click"):
		set_no_color()
		
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
		
		
func _on_BuildableSlotDisplay_mouse_entered():
	var index = get_index()
	var unit_selected = selectable_units.selected_unit is Unit
	var can_build = buildable.units[index] == null and GameManager.wave_in_progress == false
	if  unit_selected and can_build == false:
		set_red()
	elif unit_selected and can_build:
		set_green()


func _on_BuildableSlotDisplay_mouse_exited():
	set_no_color()
