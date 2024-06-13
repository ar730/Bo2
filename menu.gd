extends Control

@onready var _mainmus = $AudioStreamPlayer
@onready var alarmDedEscape = $AudioStreamPlayer2
func _ready():
	_mainmus.play()
	pass
func _on_play_pressed():
	get_tree().change_scene_to_file("res://level_2.tscn")
	pass # Replace with function body.


func _on_options_pressed():
	pass # Replace with function body.


func _on_exit_pressed():
	alarmDedEscape.play()
	await get_tree().create_timer(6).timeout
	get_tree().quit()
	pass # Replace with function body.


func _on_focus_entered(): 

	pass # Replace with function body.


func _on_mouse_entered():
	
	pass # Replace with function body.


func _on_mouse_exited():

	pass # Replace with function body.
