extends "res://Assets/Characters/CharacterController.gd"

##
# A frontend to the CharacterController which is specifically tied to the Dog
# character and moving this node based on input from the player
#
# author(s): Num0Programmer
##


class_name DogController


##
# constant attributes
##

# movement states
const WALKING : int = 0
const SPRINTING : int = 1
const IDLE : int = 2

##
# public attributes
##

# sprinting
export( float ) var sprint_speed : float = 120 # default guess


##
# private attributes
##

# movement
var current_speed : float = walk_speed

var x_input : int = 0
var y_input : int = 0


# state control
var is_sprinting : bool = false

var current_move_state : int = WALKING

onready var animated_sprite :=$AnimatedSprite

##
# initializers
##


##
# updaters
##

func _process( _delta ) -> void:
	
	get_player_input()
	
	if is_sprinting:
		
		current_move_state = SPRINTING
		current_speed = sprint_speed
		
	elif x_input != 0 or y_input != 0:
		
		current_move_state = WALKING
		current_speed = walk_speed
		
	else:
		
		current_move_state = IDLE
		animated_sprite.play("idle_r")


func _physics_process( _delta ) -> void:
	
	move()


##
# behaviours
##

func get_player_input() -> void:
	##
	# listens for input from the player and updates associated variables
	##
	
	x_input = Input.get_axis( "ui_left", "ui_right" )
	y_input = Input.get_axis( "ui_up", "ui_down" )
	
	is_sprinting = Input.is_action_pressed( "sprint" )


func move() -> void:
	
	velocity_change_by_components( x_input, y_input, 0.80, current_speed )












































