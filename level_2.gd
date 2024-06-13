extends Node3D

@onready var player = $player
var enemy = preload("res://enemy2.tscn")
func _physics_process(delta):
	get_tree().call_group("enemies", "update_target_location",player.global_transform.origin)
#	var triggered = get_node("enemy.gd")	
#	if triggered == true:
#		print("neee")


var i = 0
func _on_mob_timer_timeout():
	_add_enemy()
	Global.countVave += 1
#	var spawnEnemy = enemy.instantiate()
#	add_child(spawnEnemy)
#	Global.enemyCount += 1
func _add_enemy():	
#	var randomEnemy = randi_range(1,Global.countVave)

#	for i in range(Global.countVave) :
#
#		await get_tree().create_timer(0.4).timeout
#		i += 1
#		print("aaaa ", i)
##		spawnEnemy.position = Vector3(0,0.2,0)
#		var spawnEnemy = enemy.instantiate()
#		add_sibling(spawnEnemy)
#
#		Global.scaleHPEnemy + 10
#		Global.SpawnAccept = false
	Global.SpawnAccept = true

