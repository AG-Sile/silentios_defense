extends Resource
class_name BuildableGrid

signal unit_changed(index)

onready var unit_initial = [null].resize(90)
export(Array, Resource) var units =  unit_initial

func set_unit(unit_index, unit):
	var current_unit = units[unit_index]
	if current_unit == null:
		emit_signal("unit_changed", unit_index)
	
	
func sell_unit(unit_index):
	var selected_unit = units[unit_index]
	if selected_unit != null:
		# player_gold += unit.cost
		units[unit_index] = null
		emit_signal("unit_changed", unit_index)
