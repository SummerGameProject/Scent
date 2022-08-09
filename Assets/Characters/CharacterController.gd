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
export( float ) var walk_speed : float = 150 # the default speed for this character


##
# private attributes
##

# movement
var velocity : Vector2 = Vector2.ZERO

# graphics
onready var anim_sprite : AnimatedSprite


##
# initializers
##


##
# updaters
##


##
# behaviours
##

func sprite_anim_handler( heading : Vector2, state : String ) -> void:
	##
	# assesses the direction this object is facing/moving and determines which animations
	# to play and how to scale the sprite
	#
	# heading : the direction this object is facing/moving
	#
	# state : movement state of the sprite which points to a certain animation
	##
	
	if heading == Vector2.UP:
		
		anim_sprite.play( state + "_up" )
		
	elif heading.x > 0:
		
		anim_sprite.play( state + "_right" )
		anim_sprite.global_scale = Vector2( 1, 1 )
		
	elif heading.x < 0:
		
		anim_sprite.play( state + "_right" )
		anim_sprite.global_scale = Vector2( -1, 1 )
		
	elif heading == Vector2.DOWN: # assume heading is equal to ( 0, 1 )
		
		anim_sprite.play( state + "_down" )


func velocity_change_by_direct( move_direct : Vector2, time_step : float = 1,
		speed : float = walk_speed ) -> void:
	##
	# changes the velocity of this character using a direction vector
	# constructed by the user; it is up to the user to normalize the direction
	# vector
	#
	# move_direct : a vector which describes the direction the player's input
	#               amounts to
	#
	# time_step : the time interval the velocity should be multiplied by; most
	#             likely "delta"
	#
	# speed : the magnitude of the velocity vector; by default this is equal to
	#         WALK_SPEED
	##
	
	velocity = move_direct * speed
	
	velocity = move_and_slide( velocity * time_step )


func velocity_change_by_components( x_comp : float, y_comp : float,
		time_step : float = 1, speed : float = walk_speed ) -> void:
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
	
	var move_direct = Vector2( x_comp, y_comp ).normalized()
	
	velocity = move_direct * speed
	
	velocity = move_and_slide( velocity * time_step )
