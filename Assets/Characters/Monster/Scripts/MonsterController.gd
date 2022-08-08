extends "res://Assets/Characters/CharacterController.gd"

##
#
#
# author(s): Num0Programmer, z$
##


class_name MonsterController


##
# constants
##

# states
enum {
	IDLE = 0,
	WANDER = 1,
	CHASE = 2
}


##
# public attributes
##


# chasing
export( float ) var chase_speed : float = 90

export( float ) var reach : float = 15


# navigation
export( float ) var view_dist : float = 30

export( float ) var interest_time : float = 1


##
# private attributes
##

# game manager reference
onready var game_manager : Node = get_node_or_null( "/root/ForestLvl" )


# movement state
var state = IDLE


# navigation
var destination : Vector2 = Vector2( 0, 0 )

var path : Array
var interest_points : Array

var nav_agent : Navigation2D = null

var rn_gener : RandomNumberGenerator = RandomNumberGenerator.new()


# searching
onready var los_arrow : RayCast2D = $LOSArrow

# foot steps
onready var foot_step : AudioStreamPlayer2D = $FootStep
onready var timer : Timer = $Timer
var foot_step_timing : int = 0.6

# chase stinger
onready var stinger : AudioStreamPlayer = $ChaseStinger

# sprite reference
#onready var anim_sprite : AnimatedSprite = $AnimatedSprite # will have to change this before the game will work properly


##
# initializers
##

func _ready() -> void:
	
	var interest_point_holder = get_node_or_null( "/root/ForestLvl/InterestPoints" ) # fix this to work for any scene
	
	
	chase_speed *= GameManager.TILE_SIZE
	walk_speed *= GameManager.TILE_SIZE
	
	nav_agent = get_node_or_null( "/root/ForestLvl/Navigation" )
	
	for point in interest_point_holder.get_child_count():
		interest_points.append( interest_point_holder.get_child( point ).global_position )
	
	destination = get_interest_point()
	
	anim_sprite = $AnimatedSprite


##
# updaters
##

func _physics_process( _delta ) -> void:
	
	match state:
		
		IDLE:
			
			idle_state()
			print( "State: IDLE" )
		
		WANDER:
			
			wander_state( _delta )
			print( "State: WANDER" )
		
		CHASE:
			
			chase_state( _delta )
			print( "State: CHASE" )
	
	path = get_path_to_destination()
	check_foot_step()


##
# behaviours
##

func check_for_dog() -> bool:
	
	# get object the ray collided with
	var obj := los_arrow.get_collider()
	
	# check if the object is the "Dog"
	if obj != null and obj.get_name() == "Dog":
		
		# set destination to dog's last known destination
		destination = obj.global_position
		
		# check if the dog is close enough to defeat
		if global_position.distance_to( obj.global_position ) <= reach:
			
			game_manager.goto_game_over_screen()
		
		# return CHASING
		return true
		
	# return WANDERING
	return false

# checks if a foot step should be played
func check_foot_step():
	
	# check if the velocity is greater then 0 and
	if velocity.length() != 0 && timer.time_left <= 0 :
		play_foot_step(foot_step_timing)

func get_interest_point() -> Vector2:
	
	var rand_interest_point = rn_gener.randi_range( 0, interest_points.size() - 1 )
	
	return interest_points[ rand_interest_point ]


func get_path_to_destination() -> PoolVector2Array:
	
	return nav_agent.get_simple_path( global_position, destination, false )

# function for playing sound effect of monsters walk
func play_foot_step(step_timing):
	# plays sound effect 
	foot_step.play()
	
	# starts timer
	timer.start(step_timing)

func update_path() -> Vector2:
	
	var move_direct : Vector2 = Vector2.ZERO
	
	move_direct = global_position.direction_to( path[ 1 ] )
	
	if global_position == path[ 0 ]:
		path.pop_front()
	
	los_arrow.set_cast_to( move_direct * view_dist )
	
	return move_direct


##
# states
##

func chase_state( time_step : float ) -> void:
	
	var dog_found : bool = true
	var move_direct : Vector2 = Vector2.ZERO
	
	if path.size() > 0:
		
		move_direct = update_path()
		
		if path.size() == 1:
			
			dog_found = check_for_dog()
	
	velocity_change_by_direct( move_direct, time_step, chase_speed )
	
	sprite_anim_handler( move_direct, "mon_run" )
	#anim_sprite.play( "mon_walk_down" )
	
	if not dog_found:
		
		state = WANDER


func idle_state():
	
	sprite_anim_handler( Vector2.ZERO, "mon_idle" )
	state = WANDER


func wander_state( time_step : float ) -> void:
	
	var move_direct : Vector2 = Vector2.ZERO
	
	if path.size() > 0:
		
		move_direct = update_path()
		
		if path.size() == 1:
			
			destination = get_interest_point()
	
	velocity_change_by_direct( move_direct, time_step )
	
	sprite_anim_handler( move_direct, "mon_walk" )
	#anim_sprite.play( "mon_walk_down" )
	
	if check_for_dog():
		
		state = CHASE
