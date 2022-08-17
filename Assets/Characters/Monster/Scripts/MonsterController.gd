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

export( float ) var chase_time : float = 10


# navigation
export( float ) var view_dist : float = 30

export( float ) var interest_time : float = 1


##
# private attributes
##

var run_scene : bool = true

# game manager reference
onready var scene_root : Node = get_tree().root.get_child( 1 )
# gets the scene tree root; in the Monster's case the scene_root would be "Monster"


# movement state
var state = IDLE


# navigation
var destination : Vector2 = Vector2( 0, 0 )

var path : Array
var interest_points : Array

var nav_agent : Navigation2D = null

var rn_gener : RandomNumberGenerator = RandomNumberGenerator.new()


# searching
var chase_timer : float = 0
onready var attack_area : Area2D = $Area2D
onready var los_arrow : RayCast2D = $LOSArrow

# foot steps
onready var foot_step : AudioStreamPlayer2D = $FootStep
onready var timer : Timer = $Timer
var foot_step_timing : int = 0.6

# chase stinger
onready var stinger : AudioStreamPlayer = $ChaseStinger


##
# initializers
##

func _ready() -> void:
	
	if scene_root.name == name:
		
		print( "Cannot run while 'Monster' is root" )
		run_scene = false
	
	
	var interest_point_holder = get_node_or_null( "/root/" + scene_root.name + "/InterestPoints" )
	
	if interest_point_holder != null and interest_point_holder.get_child_count() > 0:
		
		chase_speed *= GameManager.TILE_SIZE
		walk_speed *= GameManager.TILE_SIZE
		
		nav_agent = get_node_or_null( "/root/" + scene_root.name + "/Navigation" )
		
		if nav_agent == null:
			
			print( "Cannot follow paths without a Navigation2D node" )
			run_scene = false
		
		for point in interest_point_holder.get_child_count():
			interest_points.append( interest_point_holder.get_child( point ).global_position )
		
		destination = get_interest_point()
		
		anim_sprite = $AnimatedSprite
		
	else:
		
		print( "Cannot generate paths without InterestPoints" )
		run_scene = false


##
# updaters
##

func _process( delta ) -> void:
	
	if chase_timer > 0:
		chase_timer -= delta


func _physics_process( delta ) -> void:
	
	if not run_scene:
		return
	
	match state:
		
		IDLE:
			
			idle_state()
		
		WANDER:
			
			wander_state( delta )
		
		CHASE:
			
			chase_state( delta )
	
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
	
	return move_direct.normalized()


##
# states
##

func chase_state( time_step : float ) -> void:
	
	var dog_position : Vector2 = scene_root.get_dog_position()
	var move_direct : Vector2 = Vector2.ZERO
	
	# check chase_timer greater than 0
	if chase_timer > 0:
		
		# update destination with dog's current position
		destination = dog_position
		
		if path.size() > 0:
			
			# update move_direct
			move_direct = update_path()
		
		# change velocity
		velocity_change_by_direct( move_direct, time_step, chase_speed )
		
		# animated sprite
		sprite_anim_handler( move_direct, "mon_run" )
		
	# otherwise, check for no dog
	elif not check_for_dog():
		
		# set state to WANDER
		state = WANDER


func idle_state():
	
	anim_sprite.play( "mon_idle" )
	state = WANDER


func wander_state( time_step : float ) -> void:
	
	var move_direct : Vector2 = Vector2.ZERO
	
	if path.size() > 0:
		
		move_direct = update_path()
		
		if path.size() == 1:
			
			destination = get_interest_point()
	
	velocity_change_by_direct( move_direct, time_step )
	
	sprite_anim_handler( move_direct, "mon_walk" )
	
	if check_for_dog():
		
		state = CHASE
		chase_timer = chase_time


##
# events
##

func _on_Area2D_body_entered( body ):
	
	if body.name == "Dog":
		scene_root.goto_game_over_screen()


func _on_BearTrap_stop_monster():
	# stop movement 
	
	
	# wait for watch tower fire to be done
	pass # Replace with function body.
