extends Area2D


signal wacth_tower_fire()
signal stop_monster()
signal move_monster()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BearTrap_body_entered(body):
	# check if the monster has enterd the area
	if(body.name == "Dog"):
	
		# play the bear trap animation
		$AnimationPlayer.play("trap")
		
		# stop the monster
		emit_signal("stop_monster")
		
		# wait until the trap animation is done
		yield($AnimationPlayer, "animation_finished")
		
		# create a buffer
		yield(get_tree().create_timer(1),"timeout")
		
		print("trap done")
		
		# watch tower fires shot
		emit_signal("wacth_tower_fire")
		
		
		# monster can  move again
		emit_signal("move_monster")
		
		# add a point to monsters counter
		
		# free the trap 


func _on_BearTrap_body_exited(body):
	print("exited bear trap")
