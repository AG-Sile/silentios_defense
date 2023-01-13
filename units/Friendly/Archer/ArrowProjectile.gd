extends KinematicBody2D

var velocity = Vector2.ZERO
export var acceleration = 400
export var speed = 100
var direction = Vector2.ZERO
var damage = 0
var single_attack_target = null
var attack_type = "single_target"
onready var sprite = $Sprite

func _process(delta):
	sprite.rotation = direction.angle()
	velocity = velocity.move_toward(direction * speed, acceleration * delta)
	velocity = move_and_slide(velocity)

func throw_arrow(projectile_direction, projectile_damage, projectile_attack_type, projectile_speed):
	damage = projectile_damage
	direction = projectile_direction
	attack_type = projectile_attack_type
	speed = projectile_speed
	acceleration = projectile_speed

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
