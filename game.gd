extends Node

var boss_scene = preload("res://diagetics/enemies/boss/boss.tscn")
var boss_inst

func _ready():
	$world/tutorial.connect("begin_fight", self, "begin_fight")
	$world/player.connect("player_death", self, "player_death")
	# $world/player.connect("glub_start", $world/lightning_barrier, "glub_start")
	# $world/player.connect("glub_end", $world/lightning_barrier, "glub_end")
	
	$world/player.connect("glub_start", self, "glub_start")
	$world/player.connect("glub_end", self, "glub_end")
	
	
	$win_screen/margin_container.hide()
	
	$calm_music.play()
	$waves.play()

func glub_start():
	$world/lightning_barrier.glub_start()
	if boss_inst != null:
		boss_inst.glub_start()

func glub_end():
	$world/lightning_barrier.glub_end()
	if boss_inst != null:
		boss_inst.glub_end()

func begin_fight():
	print("let us begin")
	boss_inst = boss_scene.instance()
	$world.add_child(boss_inst)
	boss_inst.global_position = $world/boss_spawn_spot.global_position
	boss_inst.player = $world/player
	
	boss_inst.connect("boss_death", self, "boss_death")
	boss_inst.connect("phase_1_end", self, "start_phase_2")
	boss_inst.connect("phase_2_end", self, "start_phase_3")
	
	$world/player.set_target(boss_inst)
	
	$world/lightning_barrier.activate()
	$world/section_manager.activate()
	
	$calm_music.stop()
	$phase_1_music.play()

func player_death():
	$world/lightning_barrier.player_death()


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func boss_death():
	$world/lightning_barrier.boss_death()
	
	$win_screen/timer.start()
	yield($win_screen/timer, "timeout")
	
	$win_screen/margin_container.show()
	
	$tween.interpolate_property($phase_3_music, "volume_db", $phase_3_music.volume_db, -80, 5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$tween.start()

func start_phase_2():
	print("phase 2!")
	$world/section_manager.section_type = "medium"
	
	$phase_1_music.stop()
	$boss_roar.play()
	
	# $phase_inbetween_timer.start()
	# yield($phase_inbetween_timer, "timeout")
	
	$phase_2_music.play()

func start_phase_3():
	print("phase 3!")
	$world/section_manager.section_type = "small"
	
	$phase_2_music.stop()
	$boss_roar.play()
	
	# $phase_inbetween_timer.start()
	# yield($phase_inbetween_timer, "timeout")
	
	$phase_3_music.play()

