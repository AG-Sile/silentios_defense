extends Node2D

const EnemyDeathEffect = preload("res://units/enemies/bat/BatDeathEffect.tscn")
onready var enemy = $Enemy

func _on_Stats_no_health():
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = enemy.global_position
	queue_free()
