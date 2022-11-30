extends Node2D


func _on_Stats_no_health():
	var hurtbox_node = get_node("UnitLive/Hurtbox")	
	hurtbox_node.invincible = false
	queue_free()
