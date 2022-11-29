extends Node2D


func spawn_enemy(enemy, index):
	if enemy is PackedScene:
		var enemy_instance = enemy.instance()
		self.add_child(enemy_instance)
		enemy_instance.global_position = global_position
