extends GridContainer

var selectable_units = preload("res://unit_selection/SelectableUnitBuilderGrid.tres")

func _ready():
	for unit_undex in selectable_units.units.size():
		update_unit_slot_display(unit_undex)


func update_unit_slot_display(unit_index):
	var unitSlotDisplay = get_child(unit_index)
	var unit = selectable_units.units[unit_index]
	unitSlotDisplay.display_unit(unit)
