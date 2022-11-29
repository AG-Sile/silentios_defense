extends KinematicBody2D

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200

enum {
	IDLE,
	MOVE_LEFT,
	CHASE, 
	ATTACK
}
var state = CHASE
var velocity = Vector2.ZERO
onready var stats = $Stats
onready var animationTree = $AnimationTree
onready var animationPlayer = $AnimationPlayer
onready var animationState = animationTree.get("parameters/playback")
onready var hitbox = $HitboxPivot/Hitbox
onready var unitDetectionZone = $UnitDetectionZone
onready var hurtbox = $Hurtbox
onready var healthbar = $Healthbar
onready var attack_range = $AttackRange

func _ready():
	healthbar.max_value = stats.max_health
	healthbar.value = stats.max_health	
	animationTree.active = true
	
func _physics_process(delta):
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			animationState.travel("Idle")
			velocity = move_and_slide(velocity)
			seek_units()
		MOVE_LEFT:
			pass
		CHASE:
			chase_state(delta)
		ATTACK:
			attack_state()
				

func seek_units():
	if unitDetectionZone.can_seek_unit():
		state = CHASE
	
func _on_Hurtbox_area_entered(area):
	if area.name == "Hitbox":
		var adjusted_damage = min(stats.health, area.damage)
		stats.health -= adjusted_damage
		healthbar.value -= adjusted_damage
		hurtbox.create_hit_effect()
		hurtbox.start_invincibility(0.5)

func chase_state(delta):
	var unit = unitDetectionZone.unit
	animationState.travel("Walk")
	var unit_in_attack_range = attack_range.unit
	if unit != null and unit_in_attack_range == null:
		var direction = (unit.global_position - global_position).normalized()
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
		velocity = move_and_slide(velocity)
		animationTree.set("parameters/Walk/blend_position", velocity)
		animationTree.set("parameters/Idle/blend_position", velocity)					
		animationTree.set("parameters/Attack/blend_position", velocity)			
	else:
		state = IDLE

func attack_state():
	animationState.travel("Attack")

func attack_animation_finished():
	state = IDLE

func _on_AttackRange_area_entered(area):
	state = ATTACK


func _on_Stats_no_health():
	print("enemy died :(")
	GameManager.gold += stats.gold_value
	GameManager.enemies -= 1
	if GameManager.enemies == 0:
		GameManager.end_wave()
		
