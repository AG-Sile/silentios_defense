extends Node2D


func spawn_unit(unit, index):
	if unit is PackedScene:
		var unit_instance = unit.instance()
		var world = get_tree().current_scene
		self.add_child(unit_instance)
		#world.call_deferred("add_child", unit_instance)
		unit_instance.global_position = global_position
