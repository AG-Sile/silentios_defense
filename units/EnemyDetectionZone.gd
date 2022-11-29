extends Area2D

var enemy = null

func can_seek_enemy():
	return enemy != null

func _on_EnemyDetectionZone_body_entered(body):
	if enemy == null:
		enemy = body


func _on_EnemyDetectionZone_body_exited(body):
	enemy = null
