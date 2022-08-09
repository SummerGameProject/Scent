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

onready var dog := $Dog


##
# updaters
##


##
# behaviours
##

func get_dog_position() -> Vector2:
	return dog.global_position


func goto_game_over_screen() -> void:
	
	var error_code = get_tree().change_scene( GAME_OVER_SCREEN_PATH )
	if error_code != 0:
		print("ERROR: ", error_code)
