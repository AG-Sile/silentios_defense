extends Resource
class_name WaveResource

export(Dictionary) var wave_enemies = {
	1: {
	  "unit": load("res://units/enemies/bat/Bat.tscn"), 
	  "number_of_units": 10
	},
	2: {
	  "unit": load("res://units/enemies/bat/Bat.tscn"), 
	  "number_of_units": 15
	},	
}
