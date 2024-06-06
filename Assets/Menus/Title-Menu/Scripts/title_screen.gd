extends Control

"""
Title screen of the game. Sends player to the first level.

Author(s): zksx
"""

var scene_path_to_load

# Called when the node enters the scene tree for the first time.
func _ready():
	$Menu/ScentLogo/AnimationPlayer.play("alive")
	$Menu/CenterRow/Buttons/startButton.grab_focus()
	for button in $Menu/CenterRow/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
	$AudioStreamPlayer.play()
	$Menu/LeafFalling/AnimationPlayer.play("leaf falling")

func _on_Button_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	$FadeIn.show()
	$FadeIn.fade_in()
	


func _on_FadeIn_fade_finished():
	return get_tree().change_scene(scene_path_to_load)
