extends Node2D

onready var PagePath = get_parent().PagePath
export(float) var textSpeed = 0.05

var Page
 
var phraseNum = 0
var phrase_finished = true
var done_reading = false

onready var PageTimer = $Timer
onready var PageIndicator = $PageOutline/Indicator
onready var PageText = $Text
onready var PageName = $Name
onready var PagePortrait = $Portrait
onready var animationPlayer = $PageOutline/Indicator/AnimationPlayer
onready var PageTurningAudio = $PageTurningAudio
func _ready():
	PageTimer.wait_time = textSpeed
	Page = getPage()
	assert(Page, "Page not found")

 
func _process(_delta):
	PageIndicator.visible = phrase_finished
	
	# check if we are reading and the user is clicking space
	if Input.is_action_just_pressed("read") && Global.can_read:
		
		# make the Pagebox visible
		visible = true
		
		# if the text is finished then go to the next phrase
		if phrase_finished:
			nextPhrase()
			
		# otherwise make all the text visible
		else:
			PageText.visible_characters = len(PageText.text)
	
	# other wise the user clicks space and we are done reading
	
 
func getPage() -> Array:
	var f = File.new()
	assert(f.file_exists(PagePath), "File path does not exist")
	
	f.open(PagePath, File.READ)
	var json = f.get_as_text()
	
	var output = parse_json(json)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []
 
func nextPhrase() -> void:
	# we don't want tje dog to move while he is reading
	Global.can_move = false
	
	# check if we are done reading all the Page
	if phraseNum >= len(Page):
		
		# set done reading to true
		done_reading = true
		
		# set global can move to true
		Global.can_move = true
		
		# turn Controls visibilty to off
		visible = false
		
		# reset phrase num
		phraseNum = 0
		
		# exit
		return
	
	# play page turning sound
	PageTurningAudio.play()
	
	# this is used just incase the user decides to reread the note
	visible = true
	
	phrase_finished = false
	
	PageName.bbcode_text = Page[phraseNum]["Name"]
	PageText.bbcode_text = Page[phraseNum]["Text"]
	
	PageText.visible_characters = 0
	
	var f = File.new()
	var img = Page[phraseNum]["Name"] + Page[phraseNum]["Emotion"] + ".png"
	if f.file_exists(img):
		PagePortrait.texture = load(img)
	else: PagePortrait.texture = null
	
	while PageText.visible_characters < len(PageText.text):
		PageText.visible_characters += 1
		
		PageTimer.start()
		yield(PageTimer, "timeout")
	
	phrase_finished = true
	phraseNum += 1
	
	# animates the nextpage button
	animationPlayer.play("ButtonMoving")
	return
