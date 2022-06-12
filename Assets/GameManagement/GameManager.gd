extends Node

##
# Manages the game's state
#
# author(s): Num0Programmer
##


class_name GameManager


##
# constants
##


##
# public attributes
##


##
# private attributes
##

# game state
var game_over : bool = false


##
# initializers
##


##
# updaters
##

func _process( _delta ) -> void:
	
	if game_over:
		
		print( "Monster has caught the player" )


##
# behaviours
##

func set_game_over( state : bool ) -> void:
	
	game_over = state
