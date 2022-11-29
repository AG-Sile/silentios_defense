extends KinematicBody2D

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200

enum {
	IDLE,
	CHASE,
	ATTACK
}
var state = CHASE
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
onready var attack_range = $AttackRange

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
	
func _on_Hurtbox_area_entered(area):
	if area.name == "Hitbox":
		var adjusted_damage = min(stats.health, area.damage)
		stats.health -= adjusted_damage
		healthbar.value -= adjusted_damage
		hurtbox.create_hit_effect()
		hurtbox.start_invincibility(0.5)

func chase_state(delta):
	sprite.visible = true
	attack_sprite.visible = false
	animationState.travel("Walk")
	var enemy = enemyDetectionZone.enemy
	var enemy_in_attack_range = attack_range.unit
	if enemy != null and enemy_in_attack_range == null:
		var direction = (enemy.global_position - global_position).normalized()
		var distance = position.distance_to(enemy.position)
		#if distance >= 140:
		#	velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		#	animationTree.set("parameters/Idle/blend_position", velocity)
		#else:
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
		velocity = move_and_slide(velocity)
		animationTree.set("parameters/Walk/blend_position", velocity)
		animationTree.set("parameters/Idle/blend_position", velocity)
		animationTree.set("parameters/Attack/blend_position", velocity)
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

