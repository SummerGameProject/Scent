extends "res://Assets/Characters/CharacterController.gd"

##
# A frontend to the CharacterController which is specifically tied to the Dog
# character and moving this node based on input from the player
#
# author(s): Num0Programmer, z$
##


class_name DogController


##
# constant attributes
##

# stats
enum {
	IDLE = 0,
	WALK = 1,
	SPRINT = 2,
	HIDING = 3,
	READING = 4,
}

##
# public attributes
##

# sprinting
export( float ) var sprint_speed : float = 350


##
# private attributes
##

var can_hide : bool = false

var hiding_pos : Vector2 = Vector2.ZERO

var reading_pos : Vector2 = Vector2.ZERO

var hidden_mod : String = "#676767"
var orig_mod : String = "#ffffff"

# state control
var state = IDLE

onready var hide_radius : Area2D = $HidingRadius


# signals
signal sprinting( position )


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
		
		HIDING:
			
			hiding_state()
		
		IDLE:
			
			idle_state()
			
		READING:
			
			reading_state()
		

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


func start_hiding() -> void:
	##
	# handles setting up the Dog for hiding; including setting the state
	##
	
	anim_sprite.modulate = hidden_mod
	anim_sprite.play( "idle_r" ) # would play some other "hiding" animation probably; this is filler
	$DogCollider2D.disabled = true
	
	global_position = hiding_pos
	
	state = HIDING


##
# states
##

func hiding_state() -> void:
	
	if Input.is_action_just_released( "hide" ):
		

		anim_sprite.modulate = orig_mod
		$DogCollider2D.disabled = false
		
		state = IDLE


func idle_state() -> void:
	
	anim_sprite.play( "idle_r" )
	
	if get_move_direct() != Vector2.ZERO:
		
		state = WALK
		
	elif Input.is_action_just_pressed( "hide" ) and can_hide:
		
		start_hiding()
		
	elif Input.is_action_just_pressed("ui_accept") && Global.can_read:
		state = READING

func sprint_state( time_step : float ) -> void:
	
	var move_direct = get_move_direct()
	
	sprite_anim_handler( move_direct, "run" )
	
	velocity_change_by_direct( move_direct, time_step, sprint_speed )
	
	if move_direct == Vector2.ZERO:
		
		state = IDLE
		
	elif Input.is_action_just_released( "sprint" ):
		
		state = WALK
		
	elif Input.is_action_just_pressed( "hide" ) and can_hide:
		
		start_hiding()
		
	elif Input.is_action_just_pressed("ui_accept") && Global.can_read:
		state = READING

func reading_state():
	# make the dogs position the notes position
	global_position = reading_pos
		
	# otherwise check if the dog is allowed to move
	if Global.can_move:
	
		# return to the idle state
		idle_state()
	


func walk_state( time_step : float ) -> void:
	
	var move_direct = get_move_direct()
	
	sprite_anim_handler( move_direct, "walk" )
	
	velocity_change_by_direct( move_direct, time_step )
	
	if move_direct == Vector2.ZERO:
		
		state = IDLE
		
	elif Input.is_action_pressed( "sprint" ):
		
		state = SPRINT
		
	elif Input.is_action_just_pressed( "hide" ) and can_hide:
		
		start_hiding()
		
	elif Input.is_action_just_pressed("ui_accept") && Global.can_read:
		state = READING


##
# events
##


func _on_HidingRadius_body_shape_entered( _body_rid, body, _body_shape_index, _local_shape_index ):
	
	can_hide = true
	
	hiding_pos = body.global_position
	hiding_pos.y -= 5


func _on_HidingRadius_body_shape_exited( _body_rid, _body, _body_shape_index, _local_shape_index ):
	
	can_hide = false


# function for when the hiding area of the dog enters another area
func _on_InteractBox_area_entered(area):
	# check to see if the area it entered is a Note area
	if(area.name == "Note"):
		
		# set the reading_pos to the notes area position
		reading_pos = area.global_position
		
		# set global can read to true
		Global.can_read = true

# function for when the hiding area of the dog exits another area
func _on_InteractBox_area_exited(area):
	# check to see if the area it entered is a Note area
	if(area.name == "Note"):
		
		# set global can read to false
		Global.can_read = false
		
##
# tests
##

# default test for GUT
func default_test():
	return "bananas"
