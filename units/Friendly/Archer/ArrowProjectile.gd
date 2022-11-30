extends KinematicBody2D

var velocity = Vector2.ZERO
const THROW_VELOCITY = Vector2(800,-400)

func throw_arrow(direction, speed):
	velocity = direction
	

func _on_Area2D_body_entered(body):
	pass # Replace with function body.


func _on_Area2D_area_entered(area):
	pass # Replace with function body.
