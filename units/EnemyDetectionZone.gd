extends Area2D

var enemy = null

func can_seek_enemy():
	print("enemy:")
	print(enemy)
	return enemy != null

func _on_EnemyDetectionZone_body_entered(body):
	if enemy == null:
		enemy = body


func _on_EnemyDetectionZone_body_exited(body):
	monitoring = false
	enemy = null
	monitoring = true
