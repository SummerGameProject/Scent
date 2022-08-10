extends Node2D

"""
Simulates the inventory of a dog; having a size of 1, and needing to move
objects with the dog

Author(s): Num0Programmer
"""

class_name Mouth


# variables

var mouth_full : bool = false

var item : Node = null
var nearby_item : Node = null


# methods

func _process( _delta ) -> void:
	pass


func _physics_process( _delta ) -> void:
	pass


func drop() -> void:
	pass


func pickup() -> void:
	pass


func swap() -> void:
	pass


func _on_PickupRadius_body_entered( body ):
	pass


func _on_PickupRadius_body_exited( body ):
	pass
