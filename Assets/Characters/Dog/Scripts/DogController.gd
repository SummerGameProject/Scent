extends "res://Assets/Characters/CharacterController.gd"

##
# A frontend to the CharacterController which is specifically tied to the Dog
# character and moving this node based on input from the player
#
# author(s): Num0Programmer
##

##
# constant attributes
##

##
# attributes
##

var x_input = 0
var y_input = 0

##
# initializers
##

##
# updaters
##

func _process( delta ):
	
	get_player_input()


func _physics_process( delta ):
	
	velocity_change_by_components( x_input, y_input, delta )

##
# behaviours
##

func get_player_input():
	##
	# listens for input from the player and updates associated variables
	##
	
	x_input = Input.get_axis( "ui_left", "ui_right" )
	y_input = Input.get_axis( "ui_up", "ui_down" )
