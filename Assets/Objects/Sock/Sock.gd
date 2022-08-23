extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var PageLabel = $LabelContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("sock")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Sock_body_entered(body):
		# checks if the body that exits the Pages body is the dog
	if body.name == "Dog":
		PageLabel.visible = true


func _on_Sock_body_exited(body):
	# checks if the body that exits the Pages body is the dog
	if body.name == "Dog":
		
		PageLabel.visible = false
