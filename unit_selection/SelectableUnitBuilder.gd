extends Resource
class_name SelectableUnitBuildableGrid

var selected_unit

export(Array, Resource) var units =  [
	null, null, null, null, null, null, null, null]

func select_unit(unit_index):
	selected_unit = units[unit_index]

	
func deselect_unit():
	selected_unit = null	

func get_unit(unit_index):
	print(units)
	units[unit_index]	
