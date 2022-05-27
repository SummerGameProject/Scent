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

export var sprint_speed = 120 # default guess
var is_sprinting = false

var current_speed = walk_speed

var x_input = 0
var y_input = 0

##
# state machine
##

enum MovementState {
	WALKING = 0,
	SPRINTING = 1
}

var current_move_state = MovementState.WALKING

##
# initializers
##

##
# updaters
##

func _process( delta ):
	
	get_player_input()
	
	if is_sprinting:
		
		current_move_state = MovementState.SPRINTING
		current_speed = sprint_speed
		
	else:
		
		current_move_state = MovementState.WALKING
		current_speed = walk_speed


func _physics_process( delta ):
	
	move( delta )

##
# behaviours
##

func get_player_input():
	##
	# listens for input from the player and updates associated variables
	##
	
	x_input = Input.get_axis( "ui_left", "ui_right" )
	y_input = Input.get_axis( "ui_up", "ui_down" )
	
	is_sprinting = Input.is_action_pressed( "sprint" )

func move( delta ):
	
	velocity_change_by_components( x_input, y_input, delta, current_speed )












































