extends KinematicBody2D

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var attack_type = "single_target"
export var unit_type = "melee"
export(PackedScene) var projectile

enum {
	IDLE,
	CHASE,
	ATTACK
}
export var state = CHASE
var velocity = Vector2.ZERO
onready var stats = $Stats
onready var animationTree = $AnimationTree
onready var animationPlayer = $AnimationPlayer2
onready var animationState = animationTree.get("parameters/playback")
onready var hitbox = $HitboxPivot/Hitbox
onready var enemyDetectionZone = $EnemyDetectionZone
onready var hurtbox = $Hurtbox
onready var sprite = $Sprite2
onready var attack_sprite = $AttackSprite
onready var healthbar = $Healthbar
onready var attack_range = $AttackRangePivot/AttackRange
onready var single_attack_target = null

func _ready():
	healthbar.max_value = stats.max_health
	healthbar.value = stats.max_health
	animationTree.active = true
	animationState.travel("Idle")
	state = IDLE
	
func _physics_process(delta):
	match state:
		IDLE:
			sprite.visible = true
			attack_sprite.visible = false			
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			animationState.travel("Idle")
			velocity = move_and_slide(velocity)
			seek_enemies()
		CHASE:
			chase_state(delta)
		ATTACK:
			attack_state()


func seek_enemies():
	if enemyDetectionZone.can_seek_enemy():
		state = CHASE

func get_attacked(damage):
	var adjusted_damage = min(stats.health, damage)
	if adjusted_damage > 0:
		decrease_hp(adjusted_damage)
		
func decrease_hp(adjusted_damage):
	stats.health -= adjusted_damage
	healthbar.value -= adjusted_damage
	hurtbox.create_hit_effect()
	hurtbox.start_invincibility(0.1)


func chase_state(delta):
	sprite.visible = true
	attack_sprite.visible = false
	animationState.travel("Walk")
	var enemy = enemyDetectionZone.enemy
	var enemy_in_attack_range = attack_range.unit_in_range()
	if is_instance_valid(enemy) and enemy_in_attack_range == false:
		var direction = (enemy.global_position - global_position).normalized()
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
		velocity = move_and_slide(velocity)
		animationTree.set("parameters/Walk/blend_position", velocity)
		animationTree.set("parameters/Idle/blend_position", velocity)
		animationTree.set("parameters/Attack/blend_position", velocity)
	elif is_instance_valid(enemy) and enemy_in_attack_range == true:
		var direction = (enemy.global_position - global_position).normalized()		
		velocity = velocity.move_toward(direction * MAX_SPEED, 10 * delta)
		velocity = move_and_slide(velocity)		
		state = ATTACK
	else:
		state = IDLE

func attack_state():
	sprite.visible = false
	attack_sprite.visible = true
	animationState.travel("Attack")


func attack_animation_finished():
	sprite.visible = true
	attack_sprite.visible = false
	state = IDLE


func _on_AttackRange_area_entered(area):
	state = ATTACK

func _on_Hitbox_area_entered(area):
	if area.name == "Hurtbox":
		var hurt_unit = area.get_node("..")
		var null_target = is_instance_valid(single_attack_target) == false
		if attack_type == "single_target":
			if null_target == true:
				single_attack_target = hurt_unit
				attack_unit(hurt_unit)
			elif null_target == false && single_attack_target == hurt_unit:
				attack_unit(hurt_unit)
		elif attack_type == "splash_damage":
			attack_unit(hurt_unit)

func attack_unit(hurt_unit):
	if unit_type == "melee":
		hurt_unit.get_attacked(stats.damage) 
	else:
		var projectile_instance = projectile.instance()
		add_child(projectile_instance)
		projectile_instance.global_position = global_position
		var direction = (hurt_unit.global_position - global_position).normalized()
		projectile_instance.throw_arrow(direction, stats.damage, attack_type,  200)
