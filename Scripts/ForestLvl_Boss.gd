extends GameManager

onready var Monster = $Monster
var call_once = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

var monster_hits = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if monster_hits >= 3 && call_once:
		call_once = false
		end_game()


func _on_BearTrap_stop_monster(bear_trap_pos,bear_trap_name):
	activate_bear_trap(bear_trap_pos,bear_trap_name)



func _on_BearTrap2_stop_monster(bear_trap_pos,bear_trap_name):
	activate_bear_trap(bear_trap_pos,bear_trap_name)


func _on_BearTrap3_stop_monster(bear_trap_pos,bear_trap_name):
	activate_bear_trap(bear_trap_pos,bear_trap_name)


func activate_bear_trap(bear_trap_pos, bear_trap_name):
	
	# setting vars for method
	var bear_trap_path = bear_trap_name
	var bear_trap_anim = bear_trap_name + "/AnimationPlayer"
	var watch_tower_anim = $WatchTower/AnimationPlayer
	var y_adjust = -20
	var x_adjust = -5
	
	# adjust position for bear trap position so the monsters feet are 
	# at the base of the trap
	bear_trap_pos.y += y_adjust
	bear_trap_pos.x += x_adjust
	
	# stop the monster from moving
	Monster.stop_state(true, bear_trap_pos)
	
	# play monster idle animation
	Monster.anim_sprite.play( "mon_idle" )
	
	# play bear trap animation
	get_node(bear_trap_anim).play("trap")
	
	# wait for bear trap animation to finish
	yield(get_node(bear_trap_anim), "animation_finished")
	
	# fire from watch tower
	watch_tower_anim.play("Fire")
	
	# wait for watch tower to get done firing
	yield(watch_tower_anim, "animation_finished")
	
	watch_tower_anim.play("Idle")
	
	# free the trap
	get_node(bear_trap_path).queue_free()
	
	# allow the monster to move again
	Monster.stop_state(false, bear_trap_pos)
	
	# add one hit to the monster
	monster_hits += 1
	

# this is what we are going to use to call a new scene or end the game
func end_game():
	print("You win!")
