extends Node2D



var selectable_units = preload("res://unit_selection/SelectableUnitBuilderGrid.tres")

func spawn_enemy(enemy):
	if enemy is PackedScene:
		var enemy_instance = enemy.instance()
		add_child(enemy_instance)
		enemy_instance.global_position = global_position
	#	enemy_instance.global_position = global_position
