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
	MOVE = 1
}

##
# public attributes
##

# sprinting
export( float ) var sprint_speed : float = 120 # default guess


##
# private attributes
##

# movement
var current_speed : float = walk_speed

var move_direct : Vector2 = Vector2.ZERO


# state control
var is_sprinting : bool = false

var state = IDLE

onready var animated_sprite : AnimatedSprite = $AnimatedSprite

##
# initializers
##


##
# updaters
##

func _physics_process( _delta : float ) -> void:
	
	match state:
		
		MOVE:
			
			move_state( _delta )
		
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
	
	animated_sprite.play( "idle_r" )
	
	if get_move_direct() != Vector2.ZERO:
		
		state = MOVE


func move_state( time_step : float ) -> void:
	
	var current_speed : float = walk_speed
	
	
	move_direct = get_move_direct()
	
	if Input.is_action_pressed( "sprint" ):
		
		current_speed = sprint_speed
	
	match move_direct:
		
		Vector2.UP:
			
			# play animation for walking in northern direction
			pass
		
		Vector2.RIGHT:
			
			# play animation for walking in eastern direction
			
			# set sprite scale to ( 1, 1 )
			animated_sprite.global_scale = Vector2( 1, 1 )
		
		Vector2.LEFT:
			
			# play animation for walking in western direction
			
			# set sprite scale to ( -1, 1 )
			animated_sprite.global_scale = Vector2( -1, 1 )
		
		Vector2.DOWN:
			
			# play animation for walking in southern direction
			animated_sprite.play( "walk_down" )
	
	velocity_change_by_direct( move_direct, 0.80, current_speed )
	
	if move_direct == Vector2.ZERO:
		
		state = IDLE












































