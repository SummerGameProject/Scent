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
const IDLE : int = 0
const WALKING : int = 1
const SPRINTING : int = 2

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

var x_input : float = 0
var y_input : float = 0


# state control
var is_sprinting : bool = false

var current_state : int = WALKING

onready var animated_sprite : AnimatedSprite = $AnimatedSprite

##
# initializers
##


##
# updaters
##

func _process( _delta ) -> void:
	
	get_player_input()
	current_state = change_state()
	
	# check for SPRINTING state
	if current_state == SPRINTING:
		
		# change dog's current speed to sprinting speed
		current_speed = sprint_speed
		
		# play sprinting animation
		
	# otherwise, check for WALKING state
	elif current_state == WALKING:
		
		# change dog's current speed to walking speed
		current_speed = walk_speed
		
		# play walking animation
		
	# otherwise, assume IDLE state
	else:
		
		# play idle animation
		animated_sprite.play( "idle_r" )


func _physics_process( _delta ) -> void:
	
	move()


##
# behaviours
##

func change_state() -> int:
	##
	# assesses the user's input and dog's attributes to determine the dog's state
	##
	
	# check x input not equal to 0 or y input not equal to 0
	if x_input != 0 or y_input != 0:
		
		# check for sprinting
		if is_sprinting:
			
			# return SPRINTING
			return SPRINTING
			
		# return WALKING
		return WALKING
	
	# return IDLE
	return IDLE


func get_player_input() -> void:
	##
	# listens for input from the player and updates associated variables
	##
	
	x_input = Input.get_axis( "ui_left", "ui_right" )
	y_input = Input.get_axis( "ui_up", "ui_down" )
	
	is_sprinting = Input.is_action_pressed( "sprint" )


func move() -> void:
	
	velocity_change_by_components( x_input, y_input, 0.80, current_speed )












































