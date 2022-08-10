extends Node2D

"""
Simulates the inventory of a dog; having a size of 1, and needing to move
objects with the dog

Author(s): Num0Programmer
"""

class_name Mouth


# variables

var item : Node2D = null
var nearby_item : Node2D = null

var rn_gener : RandomNumberGenerator = RandomNumberGenerator.new() 


# methods

func _process( _delta ) -> void:
	
	if Input.is_action_just_pressed( "pickup" ):
		
		if item == null:
			
			pickup()
			
		elif nearby_item != null:
			
			swap( _delta )
			
		else:
			
			drop( _delta )


func _physics_process( _delta ) -> void:
	
	if item != null:
		
		item.global_position = item.global_position.move_toward( global_position, _delta )


func drop( delta : float ) -> void:
	
	var rand_pos : Vector2 = Vector2.ZERO
	
	rand_pos.x = rn_gener.randf_range( global_position.x - 0.7, global_position.x + 0.7 )
	rand_pos.y = rn_gener.randf_range( global_position.y - 0.7, global_position.y + 0.7 )
	
	item.global_position = item.global_position.move_toward( rand_pos, delta )
	
	item = null


func pickup() -> void:
	
	item = nearby_item
	item.global_position = global_position


func swap( delta : float ) -> void:
	
	drop( delta )
	pickup()


func _on_PickupRadius_body_entered( _body ):
	nearby_item = _body


func _on_PickupRadius_body_exited( _body ):
	nearby_item = null
