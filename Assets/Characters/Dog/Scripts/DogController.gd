extends KinematicBody2D

# author(s): Num0Programmer

# public

export( float ) var walk_speed : float = 65

export( float ) var sprint_speed : float = 120

export( Vector2 ) var velocity : Vector2 = Vector2.ZERO

# private

var is_sprinting : bool = false

# holds the magnitude of input on the horizontal (x) axis; can be negative
var xInput : float = 0

# holds the magnitude of input on the vertical (y) axis; can be negative
var yInput : float = 0

# initialization

# updaters

func _process( delta ):
	
	get_input()

func _physics_process( delta ):
	
	velocity_change()

# behaviors

func get_input() -> void:
	##
	# desc: listens for input from the user and updates associated variables
	#       accordingly
	##
	
	xInput = Input.get_axis( "move_left", "move_right" )
	
	# inputs are backwards because I don't know why
	yInput = Input.get_axis( "move_up", "move_down" )
	
	is_sprinting = Input.is_action_pressed( "sprint" )

func velocity_change() -> void:
	##
	# desc: updates the "velocity" attribute according to axis inputs
	#
	# note(s): - this method does call the "move_and_slide()" method on the
	#            KinematicBody2D
	##
	
	var current_speed : float = walk_speed
	
	if is_sprinting:
		current_speed = sprint_speed
	
	velocity.x = xInput * current_speed
	velocity.y = yInput * current_speed
	
	velocity = move_and_slide( velocity, Vector2.UP )
