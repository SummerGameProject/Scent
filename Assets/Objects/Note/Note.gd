extends Area2D
onready var PageLabel = $LabelContainer
onready var PageBox = $Page/PageOutline
var can_interact = false

# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass
	
# function that detects when a body enters the Pages body
func _on_Note_body_entered(body):
	
	# checks if the body that enters the Pages body is the dog
	if body.name == "Dog":
		
		PageLabel.visible = true
		
		can_interact = true

# function that detects when a body exits the Pages body
func _on_Note_body_exited(body):
	
	# checks if the body that exits the Pages body is the dog
	if body.name == "Dog":
		
		PageLabel.visible = false
		
		can_interact = false

# function for detecting input to read the Page
func _input(_event):
	#checking if the space button is pressed and can be interacted with

	if Input.is_action_just_pressed("ui_accept") and can_interact:

		# turns the Pages label to invisible
		PageLabel.visible = false
		
		# turns the Pages text to visible
		PageBox.visible = true
