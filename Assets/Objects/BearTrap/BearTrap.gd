extends Area2D


signal wacth_tower_fire()
signal stop_monster()
signal move_monster()

var pos = position

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_BearTrap_body_entered(body):
	# check if the monster entered the body 
	if body.name == "Monster":
	
		# emit signal for stop monster
		emit_signal("stop_monster", global_position, name )
		
		


func _on_BearTrap2_body_entered(body):
		# check if the monster entered the body 
	if body.name == "Monster":
	
		# emit signal for stop monster
		emit_signal("stop_monster", global_position, name )
				


func _on_BearTrap3_body_entered(body):
	# check if the monster entered the body 
	if body.name == "Monster":
	
		# emit signal for stop monster
		emit_signal("stop_monster", global_position, name )
		
