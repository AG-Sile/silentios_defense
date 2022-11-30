extends Area2D

var enemy = null

func can_seek_enemy():
	if is_instance_valid(enemy) == false:
		enemy = null
		find_closest_body()
	return enemy != null

func _on_EnemyDetectionZone_body_entered(body):
	if enemy == null:
		enemy = body


func _on_EnemyDetectionZone_body_exited(body):
	enemy = null
	find_closest_body()
			
func find_closest_body():
	var new_bodies = get_overlapping_bodies()
	if new_bodies.size() > 0:
		var closest_body = null
		var min_distance = null
		for new_body in new_bodies:
			var distance = get_node("..").transform.origin.distance_to(new_body.transform.origin)
			if min_distance == null or min_distance < distance:
				min_distance = distance
				closest_body = new_body
		enemy = closest_body	
