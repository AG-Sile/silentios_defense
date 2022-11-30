extends CenterContainer

var selectable_units = preload("res://unit_selection/SelectableUnitBuilderGrid.tres")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var unitTextureRect = $TextureRect

func _ready():
	var index = get_index()	
	var selectable_unit = selectable_units.units[index]	
	if selectable_unit != null:
		create_hover_info(selectable_unit)

func _process(delta):
	if Input.is_action_just_released("ui_right_button_click", false):
		selectable_units.deselect_unit()

func create_hover_info(selectable_unit):
	var hover_control = get_node("HoverControl")
	var hover_info = hover_control.get_node("HoverInfo")
	var gold_cost = hover_info.get_node("GoldCost")
	var attack_speed = hover_info.get_node("AttackSpeed")
	var unit_type = hover_info.get_node("UnitType")
	var unit_name = hover_info.get_node("UnitName")
	gold_cost.text = str(selectable_unit.gold_cost)
	attack_speed.text = str(selectable_unit.attack_speed)
	unit_type.text = str(selectable_unit.unit_type)
	unit_name.text = str(selectable_unit.unit_name)

func display_unit(unit):
	if unit is Unit:
		unitTextureRect.texture = unit.texture
	else:
		unitTextureRect.texture = load("res://tiles/grass and cliffs/inventory_slot.png")
	
func _gui_input(event):
	var select_unit_event = event is InputEventMouseButton and event.is_action_released("ui_left_button_click")
	if select_unit_event:
		select_unit_to_build()

func select_unit_to_build():
		var index = get_index()
		var unit_gold_cost = selectable_units.units[index].gold_cost
		if unit_gold_cost <= GameManager.gold:
			selectable_units.select_unit(index)
		else:
			var insufficient_funds_container = get_node("InsufficientFundsContainer")
			var insufficient_funds = insufficient_funds_container.get_node("InsufficientFundsLabel")
			insufficient_funds_container.visible = true
			var timer = insufficient_funds_container.get_node("Timer")
			timer.start(1)

func _on_BuildableUnitSlot_mouse_entered():
	var hover_control = get_node("HoverControl")
	hover_control.visible = true


func _on_BuildableUnitSlot_mouse_exited():
	var hover_control = get_node("HoverControl")
	hover_control.visible = false

