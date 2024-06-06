extends Area2D


signal wacth_tower_fire()
signal stop_monster()
signal move_monster()

var pos = position



func _on_BearTrap_body_entered(body):
	if body.name == "Monster":
		emit_signal("stop_monster", global_position, name )
		
		


func _on_BearTrap2_body_entered(body):
	if body.name == "Monster":
		emit_signal("stop_monster", global_position, name )
				


func _on_BearTrap3_body_entered(body):
	if body.name == "Monster":
		emit_signal("stop_monster", global_position, name )
		
