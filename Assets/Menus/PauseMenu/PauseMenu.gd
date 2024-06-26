extends Control

"""
Allows the player to pause the game and takes them to a pause screen

Author(s): zksx
"""

var is_paused = false setget set_is_paused

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		self.is_paused = !is_paused
		

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused
	$CenterContainer/VBoxContainer/ResumeButton.grab_focus()
	$PausedTitle/AnimationPlayer.play("alive")


func _on_ResumeButton_pressed():
	self.is_paused = false


func _on_QuitButton_pressed():
	get_tree().quit()


	
