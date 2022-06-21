extends "res://Assets/Characters/CharacterController.gd"

##
#
#
# author(s): Num0Programmer
##


class_name MonsterController


##
# constants
##

# movement states
const WANDERING : int = 0
const CHASING : int = 1


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


# movement
var current_speed : float = walk_speed


# movement state
var current_state : int = WANDERING


# navigation
var destination : Vector2 = Vector2( 0, 0 )

var path : Array
var interest_points : Array

var nav_agent : Navigation2D = null

var rn_gener : RandomNumberGenerator = RandomNumberGenerator.new()


# searching
onready var los_arrow : RayCast2D = $LOSArrow


##
# initializers
##

func _ready() -> void:
	
	var interest_point_holder = get_node_or_null( "/root/ForestLvl/InterestPoints" )
	
	nav_agent = get_node_or_null( "/root/ForestLvl/Navigation" )
	
	for point in interest_point_holder.get_child_count():
		interest_points.append( interest_point_holder.get_child( point ).global_position )


##
# updaters
##

func _process( _delta ) -> void:
	
	current_state = check_for_dog()
	
	# check for CHASING state
	if current_state == CHASING:
		
		current_speed = chase_speed
		
	else: # assuming in WANDERING
		
		current_speed = walk_speed
		
		# check for no path or that the path is almost gone
		if path.size() == 0 or path.size() == 1:
			
			destination = get_interest_point()
	
	get_path_to_destination()


func _physics_process( _delta ) -> void:
	
	move()
	
	los_arrow.set_cast_to( velocity.normalized() * view_dist )


##
# behaviours
##

func check_for_dog() -> int:
	
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
		return CHASING
		
	# return WANDERING
	return WANDERING


func get_interest_point() -> Vector2:
	
	var rand_interest_point = rn_gener.randi_range( 0, interest_points.size() - 1 )
	
	return interest_points[ rand_interest_point ]


func get_path_to_destination() -> void:
	
	if nav_agent != null:
		
		path = nav_agent.get_simple_path( global_position, destination, false )


func move() -> void:
	
	var move_direct : Vector2 = Vector2.ZERO
	
	if path.size() > 0:
		
		move_direct = global_position.direction_to( path[ 1 ] )
		
		if global_position == path[ 0 ]:
			path.pop_front()
	
	velocity_change_by_direct( move_direct, 0.80, current_speed )






















