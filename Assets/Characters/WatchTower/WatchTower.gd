extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BearTrap_wacth_tower_fire():
	# play the fire animation and sound
	$AnimationPlayer.play("Fire")
	
	#wait until the animation is done
	yield($AnimationPlayer, "animation_finished")
