extends Area2D
export(String) var next_level

"""
Changes the scene to the next level once the Player/Dog enters the area

Author(s): zksx
"""

func _on_SceneChangeArea_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	var error_code
	# check if the body is the dogs
	if(body.name == "Dog"):
		# change scene to next level
		error_code = get_tree().change_scene(next_level)
		if error_code != 0:
			print("ERROR: ", error_code)
