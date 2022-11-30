extends Area2D

var unit = null

func can_seek_unit():
	return unit != null

func _on_UnitDetectionZone_body_entered(body):
	if unit == null:
		unit = body


func _on_UnitDetectionZone_body_exited(body):
	monitoring = false
	unit = null
	monitoring = true

