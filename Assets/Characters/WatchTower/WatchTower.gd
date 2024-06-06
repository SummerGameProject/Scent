extends StaticBody2D

signal tower_finished()

func _on_BearTrap_wacth_tower_fire():

	$AnimationPlayer.play("Fire")
	yield($AnimationPlayer, "animation_finished")
	emit_signal("tower_finished")
