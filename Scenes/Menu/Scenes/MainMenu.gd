extends Control

var master_bus = AudioServer.get_bus_index("Master")

func _ready():
	$Options.visible = false;
	$Menu/StartButton.grab_focus()
	
	if $MenuMusic.playing == false:
		$MenuMusic.play()
	pass
	
	transitionIn()
	
func transitionIn():
	$TransitionRect/Fade.play("FadeToScene")
	
func transitionOut():
	$TransitionRect/Fade.play("FadeToBlack")
	
func _on_StartButton_pressed():
# warning-ignore:return_value_discarded
	transitionOut()
	
	# timer function
	var timer = Timer.new()
	timer.set_wait_time(1)
	timer.set_one_shot(true)
	self.add_child(timer)
	timer.start()
	yield(timer, "timeout")
	timer.queue_free()
	
	# change scenes
	get_tree().change_scene("res://Areas/World.tscn")
	
func _on_OptionsButton_pressed():
	$Menu.visible = false;
	$Options.visible = true;
	$Options/BackButton.grab_focus()
	
func _on_VolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)
	
	if value == -30:
		AudioServer.set_bus_mute(master_bus,true)
	else:
		AudioServer.set_bus_mute(master_bus, false)
	
func _on_BackButton_pressed():
	$Menu.visible = true;
	$Options.visible = false;
	$Menu/StartButton.grab_focus()
	
func _on_QuitButton_pressed():
	get_tree().quit()
