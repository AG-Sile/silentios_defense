extends Node

export var max_health = 1
export var gold_value = 0
onready var health = max_health setget set_health

signal no_health

func set_health(value):
	health = value
	if health <= 0:
		emit_signal("no_health")