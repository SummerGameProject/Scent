extends KinematicBody2D


"""
Author(s): Num0Programmer
"""


class_name Footprints


onready var sprite : Sprite = $Sprite


func cover() -> void:
	sprite.modulate.a = 0


func uncover() -> void:
	sprite.modulate.a = 255
