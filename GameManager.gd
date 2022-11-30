extends Node

var wave_resource = preload("res://WaveInfo.gd")
var buildable_units = preload("res://buildable_area/buildable_grid.tres")
var spawn_area_grid = preload("res://spawn_area/SpawnAreaGridContainer.tscn")
var spawnable_unit = preload("res://SpawnableUnit.tscn")
var enemies = 0
onready var wave_in_progress = false
export var gold = 50 setget gold_display_set
export var wave_number = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	self.gold = 30

func gold_display_set(new_value):
	gold = new_value
	var main = get_tree().current_scene	
	var gold_display = main.get_node("WaveManager/GoldAndWaveLabels/GoldAmount")
	gold_display.text = str(gold)


func end_wave():
	wave_in_progress = false
	reset_units()
	
func start_wave():
	wave_number += 1
	wave_in_progress = true
	spawn_enemy()
	
func spawn_enemy():
	var wave_enemies_info = wave_resource.new().wave_enemies[wave_number]
	var main = get_tree().current_scene
	var spawnable_unit_node = main.get_node("SpawnableUnits")
	for enemy_number in wave_enemies_info["number_of_units"]:
		var spawn_area_container = spawnable_unit_node.get_child(enemy_number)
		spawn_area_container.spawn_enemy(wave_enemies_info["unit"], enemy_number)
		enemies += 1
		
func reset_units():
	var main = get_tree().current_scene	
	var spawnable_unit_node = main.get_node("BuildableUnits")	
	for unit_node in spawnable_unit_node.get_children():
		if unit_node.get_child_count() > 0:
			unit_node.get_child(0).queue_free()
		
	var buildable_area = main.get_node("Terrain/BuildableArea/BuildableDisplay")
	buildable_area.update_buildable_display()

