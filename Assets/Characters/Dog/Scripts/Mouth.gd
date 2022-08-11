extends Node2D

"""
Simulates the inventory of a dog; having a size of 1, and needing to move
objects with the dog

Author(s): Num0Programmer
"""

class_name Mouth


# variables

export( float ) var drop_radius : float = 5

var item : Node2D = null
var nearby_item : Node2D = null

var rn_gener : RandomNumberGenerator = RandomNumberGenerator.new() 


# methods

func _ready() -> void:
	
	drop_radius *= GameManager.TILE_SIZE


func _process( _delta ) -> void:
	
	if Input.is_action_just_pressed( "pickup" ):
		
		if item == null and nearby_item != null:
			
			pickup()
			
		elif nearby_item != null:
			
			swap( _delta )
			
		elif item != null:
			
			drop( _delta )


func _physics_process( _delta ) -> void:
	
	if item != null:
		
		item.global_position = global_position


func drop( _delta : float ) -> void:
	
	var rand_pos : Vector2 = Vector2.ZERO
	
	rand_pos.x = rn_gener.randf_range( global_position.x - drop_radius,
						global_position.x + drop_radius )
	rand_pos.y = rn_gener.randf_range( global_position.y - drop_radius,
						global_position.y + drop_radius )
	
	item.global_position = rand_pos
	item.get_child( 0 ).disabled = false
	
	item = null


func pickup() -> void:
	
	item = nearby_item
	item.get_child( 0 ).disabled = true
	item.global_position = global_position


func swap( delta : float ) -> void:
	
	drop( delta )
	pickup()


func _on_PickupRadius_body_entered( _body ):
	nearby_item = _body


func _on_PickupRadius_body_exited( _body ):
	nearby_item = null
