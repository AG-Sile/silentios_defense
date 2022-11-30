extends Node2D


export(Dictionary) var wave_enemies = {
	1: {
	  "unit": load("res://units/enemies/bat/Bat.tscn"), 
	  "number_of_units": 2
	},
	2: {
	  "unit": load("res://units/enemies/bat/Bat.tscn"), 
	  "number_of_units": 15
	},	
}
