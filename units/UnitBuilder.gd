extends Resource
class_name Unit

export var selected = false
export(String) var unit_name = ""
export(Texture) var texture
export(int) var gold_cost = 0
export(PackedScene) var unit_scene
export(String) var attack_speed
export(String) var unit_type
export(PackedScene) var projectile

func _ready():
	pass

func _process(delta):
	pass



#func _on_Area2D_input_event(viewport, event, shape_idx):
#	pass
	
#func _unhandled_input(event):
#	if event is InputEventMouseButton && event.is_pressed() && event.button_index == 1:
#		selected = true
#	elif event is InputEventMouseButton && event.is_pressed() && event.button_index == 2:
#		selected = false
