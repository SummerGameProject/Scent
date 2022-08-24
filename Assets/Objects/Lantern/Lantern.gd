extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var PageLabel = $LabelContainer
var can_use = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pickup") && can_use:
		PageLabel.visible = false



func _on_Area2D_body_entered(body):
	# checks if the body that enters the Pages body is the dog
	if body.name == "Dog":
		PageLabel.visible = true
		can_use = true
		


func _on_Area2D_body_exited(body):
	# checks if the body that exits the Pages body is the dog
	if body.name == "Dog":
		PageLabel.visible = false
		can_use = false
