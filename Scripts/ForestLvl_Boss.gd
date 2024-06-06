extends GameManager

"""
Logic for the final level. Uses the watcher tower, monsterm, and bear trap nodes
to put together the final boss fight

Author(s): zksx
"""

onready var Monster = $Monster
var call_once = true
export(String) var next_level

var monster_hits = 0

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
	
	Monster.stop_state(true, bear_trap_pos)
	Monster.anim_sprite.play( "mon_idle" )
	get_node(bear_trap_anim).play("trap")
	yield(get_node(bear_trap_anim), "animation_finished")
	
	watch_tower_anim.play("Fire")
	yield(watch_tower_anim, "animation_finished")
	watch_tower_anim.play("Idle")
	
	get_node(bear_trap_path).queue_free()
	Monster.stop_state(false, bear_trap_pos)
	
	monster_hits += 1


func end_game():
	var error_code
	error_code = get_tree().change_scene(next_level)
	if error_code != 0:
		print("ERROR: ", error_code)
