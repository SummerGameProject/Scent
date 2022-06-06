extends KinematicBody2D

##
# Base script which holds all data and functionality related to character
# control
#
# Possible extensions of this class may include a "player controller" script to
# act as the backend front to moving the parent node around the game world;
# similarly an artificial intelligence script could be the extension which is
# the processor of all incoming information, and then invokes this script's
# functions to move the designated "enemy" node this script is tied to
#
# author(s): Num0Programmer
##


##
# constant attributes
##


##
# public attributes
##

# character name
export( String ) var character_name : String = "Default"


# movement
export( float ) var walk_speed : float = 65 # the default speed for this character


##
# private attributes
##

# movement
var velocity : Vector2 = Vector2.ZERO


##
# initializers
##


##
# updaters
##


##
# behaviours
##


func velocity_change_by_direct( wish_direct, time_step = 1,
		speed = walk_speed ) -> void:
	##
	# changes the velocity of this character using a direction vector
	# constructed by the user; it is up to the user to normalize the direction
	# vector
	#
	# wish_direct : a vector which describes the direction the player's input
	#               amounts to
	#
	# time_step : the time interval the velocity should be multiplied by; most
	#             likely "delta"
	#
	# speed : the magnitude of the velocity vector; by default this is equal to
	#         WALK_SPEED
	##
	
	velocity = wish_direct * speed * time_step
	
	velocity = move_and_slide( velocity )


func velocity_change_by_components( x_comp, y_comp, time_step = 1,
		speed = walk_speed ) -> void:
	##
	# changes the velocity of this character using the given x and y components;
	# this function normalizes the components by default
	#
	# x_comp : the length of the velocity's x component
	#
	# y_comp : the length of the velocity's y component
	#
	# time_step : the time interval the velocity should be multiplied by; most
	#             likely "delta"
	#
	# speed : the magnitude of the velocity vector; by default this is equal to
	#         WALK_SPEED
	##
	
	var wish_direct = Vector2( x_comp, y_comp ).normalized()
	
	velocity = wish_direct * speed * time_step
	
	velocity = move_and_slide( velocity )
