extends Area2D
export(String) var next_level

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#ssssdadsafdasfddfasfasd unique
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SceneChangeArea_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	# check if the body is the dogs
	if(body.name == "Dog"):
		# change scene to next level
		get_tree().change_scene(next_level )
