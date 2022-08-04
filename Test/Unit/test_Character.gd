extends 'res://addons/gut/test.gd'

var Dog = load("res://Assets/Characters/Dog/Scripts/DogController.gd")
var _dog = null

# func performs actions before every test
func before_each():
	# creates a new dog
	_dog = Dog.new()

# func performs actions after every test
func after_each():
	# frees dog
	_dog.free()

# default test that should always pass regardless of changes
func test_default_test():
	
	var result = _dog.default_test()
	
	assert_eq(result, "bananas", "result should have been bananas")
	
	pass
