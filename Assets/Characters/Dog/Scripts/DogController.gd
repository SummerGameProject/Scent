extends "res://Assets/Characters/CharacterController.gd"

##
# A frontend to the CharacterController which is specifically tied to the Dog
# character and moving this node based on input from the player
#
# author(s): Num0Programmer
##


class_name DogController


##
# constant attributes
##

# stats
enum {
	IDLE = 0,
	WALK = 1,
	SPRINT = 2
}

##
# public attributes
##

# sprinting
export( float ) var sprint_speed : float = 120


##
# private attributes
##

# state control
var state = IDLE


##
# initializers
##

func _ready() -> void:
	
	sprint_speed *= GameManager.TILE_SIZE
	walk_speed *= GameManager.TILE_SIZE
	
	anim_sprite = $AnimatedSprite


##
# updaters
##

func _physics_process( _delta : float ) -> void:
	
	match state:
		
		WALK:
			
			walk_state( _delta )
		
		SPRINT:
			
			sprint_state( _delta )
		
		IDLE:
			
			idle_state()


##
# behaviours
##


func get_move_direct() -> Vector2:
	##
	# returns normalized direction Vector2
	##
	
	var received_direct : Vector2 = Vector2.ZERO
	
	received_direct.x = Input.get_axis( "ui_left", "ui_right" )
	received_direct.y = Input.get_axis( "ui_up", "ui_down" )
	
	return received_direct.normalized()


##
# states
##

func idle_state() -> void:
	
	anim_sprite.play( "idle_r" )
	
	if get_move_direct() != Vector2.ZERO:
		
		state = WALK


func walk_state( time_step : float ) -> void:
	
	var move_direct = get_move_direct()
	
	sprite_anim_handler( move_direct, "walk" )
	
	velocity_change_by_direct( move_direct, time_step )
	
	if move_direct == Vector2.ZERO:
		
		state = IDLE
		
	elif Input.is_action_pressed( "sprint" ):
		
		state = SPRINT


func sprint_state( time_step : float ) -> void:
	
	var move_direct = get_move_direct()
	
	sprite_anim_handler( move_direct, "run" )
	
	velocity_change_by_direct( move_direct, time_step, sprint_speed )
	
	if move_direct == Vector2.ZERO:
		
		state = IDLE
		
	elif Input.is_action_just_released( "sprint" ):
		
		state = WALK












































