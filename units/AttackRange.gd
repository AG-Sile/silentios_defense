extends Area2D

var unit = null

func unit_in_range():
	unit != null

func _on_AttackRange_area_entered(area):
	unit = area


func _on_AttackRange_area_exited(area):
	unit = null # Replace with function body.
