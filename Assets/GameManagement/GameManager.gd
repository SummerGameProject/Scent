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

const TILE_SIZE : int = 16
const GAME_OVER_SCREEN_PATH = "res://Scenes/GameOverScreen.tscn"


##
# public attributes
##


##
# private attributes
##


##
# initializers
##


##
# updaters
##


##
# behaviours
##

func goto_game_over_screen() -> void:
	
	get_tree().change_scene( GAME_OVER_SCREEN_PATH )
