extends KinematicBody2D

var velocity = Vector2.ZERO
export var ACCELERATION = 300
export var MAX_SPEED = 100
var direction = Vector2.ZERO
var damage = 0
var single_attack_target = null
var attack_type = "single_target"

func _process(delta):
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	velocity = move_and_slide(velocity)	

func throw_arrow(projectile_direction, projectile_damage, projectile_attack_type, speed):
	damage = projectile_damage
	direction = projectile_direction
	attack_type = projectile_attack_type

func _on_Area2D_area_entered(area):
	if area.name == "Hurtbox":
		var hurt_unit = area.get_node("..")
		var null_target = is_instance_valid(single_attack_target) == false
		if attack_type == "single_target":
			if null_target == true:
				single_attack_target = hurt_unit
				hurt_unit.get_attacked(damage)
				queue_free() 
			elif null_target == false && single_attack_target == hurt_unit:
				hurt_unit.get_attacked(damage)
				queue_free()  
		elif attack_type == "splash_damage":
			hurt_unit.get_attacked(damage) 
			queue_free() 
