extends GridContainer

var buildable = preload("res://buildable_area/buildable_grid.tres")

func _ready():
	buildable.connect("unit_changed", self, "_on_unit_changed")
	update_buildable_display()
	
func update_buildable_display():

	for unit_index in buildable.units.size():
		update_buildable_slot_display(unit_index)

func update_buildable_slot_display(unit_index):
	var unitSlotDisplay = get_child(unit_index)
	var childer = get_child_count()
	var unit = buildable.units[unit_index]
	unitSlotDisplay.display_unit(unit)
	
