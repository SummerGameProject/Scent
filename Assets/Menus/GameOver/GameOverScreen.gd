extends Node

##
# Provides the backend functionality for the Game Over Screen
#
# Author(s): Num0Programmer
##

##
# constants
##


##
# public : attributes
##


##
# private : attributes
##

# button initialization

onready var exit_btn : Button = $ExitBtn
onready var replay_btn : Button = $ReplayBtn
onready var main_menu_btn : Button = $MainMenuBtn


##
# initializers
##

func _ready():
	
	exit_btn.connect( "button_down", self, "on_exit_btn_pressed" )
	replay_btn.connect( "button_down", self, "on_replay_btn_pressed" )
	main_menu_btn.connect( "button_down", self, "on_main_menu_btn_pressed" )


##
# updaters
##


##
# behaviours
##

func on_exit_btn_pressed() -> void:
	
	get_tree().quit()


func on_main_menu_btn_pressed() -> void:
	
	print( "Main Menu is not hooked up yet!" )


func on_replay_btn_pressed() -> void:
	
	get_tree().change_scene( "res://Scenes/ForestLvl.tscn" )
