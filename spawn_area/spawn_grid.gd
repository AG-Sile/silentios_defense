extends Resource
class_name SpawnGrid

signal enemy_changed(index)

onready var enemy_initial = [null].resize(30)
export(Array, Resource) var enemies =  enemy_initial

func set_enemy(enemy_index, enemy):
	var current_enemy = enemies[enemy_index]
	if current_enemy == null:
		emit_signal("enemy_changed", enemy_index)
	
	
