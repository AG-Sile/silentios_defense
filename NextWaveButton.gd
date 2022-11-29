extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameManager.wave_in_progress == true && disabled == false:
		disabled = true
		flat = true
	elif GameManager.wave_in_progress == false && disabled == true:
		disabled = false
		flat = false
		
func _on_NextWaveButton_pressed():
	GameManager.start_wave()
	var wave_number_label = get_parent().get_node("GoldAndWaveLabels/WaveNumber")
	wave_number_label.text = str(GameManager.wave_number)
