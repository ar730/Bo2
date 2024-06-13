extends  CharacterBody3D

@onready var trigMus = $triggeredSound
@onready var nav_agent = $NavigationAgent3D
@onready var bulletenemy = preload("res://bullet_2enemy.tscn")
@onready var bullet_spawn_point = $bulletspawn
@onready var damagesound = $AudioStreamPlayer3D
@onready var walkzombieAnim = $AnimationPlayer
@onready var level2 = preload("res://level_2.tscn")


var health = 100  # Здоровье цели
var bulletspeed = 10
var triggered = true
var acceptshoot = 0
var SPEED = 12


var checkEnemyID = "Node3D"

var i = 1
var acceptSpawn = null
func _ready():
	pass

	
func  _physics_process(delta):

	health = health + Global.scaleHPEnemy
	if health <= 110:
		$MeshInstance3D3.hide()


	await get_tree().physics_frame
	var current_location = global_transform.origin
	await get_tree().create_timer(0.1).timeout
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	var aaaa = nav_agent.target_position
	velocity = new_velocity

	
	move_and_slide()
	
	if triggered == true:
		walkzombieAnim.play("Take 001")
		look_at(next_location)
		velocity = velocity.move_toward(new_velocity, .25)
		

func update_target_location(target_location):
	nav_agent.target_position = target_location
#	print(nav_agent.target_position, "AAAA")
#func update_target_location(target_location):
#
#	nav_agent.target_position = target_location 
#	print(nav_agent.target_position, "AAAA")




func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	pass 


func _on_navigation_agent_3d_target_reached():

	triggered = true


	pass 


func take_damage(amount):
	health -= amount
	$Sprite3D/SubViewport/EnemyHP.set_value(health)
	damagesound.play()
	if health <= 0:
		Global.score += 10
		die()



func die():
	# Логика смерти цели
#	if Global.SpawnAccept == true:
	var tempIDEnemy = get_parent()
	var IndexDied = str(tempIDEnemy)

	Global.enemyCount -= 1
	if checkEnemyID in IndexDied:
		Global.enemyID = tempIDEnemy
	
	Global.enemyID._add_enemy()
	
	call_deferred("free") # Уничтожаем цель после смерти
	pass

var thunder = 0
func take_damage_player(amount):
	health -= amount
	$Sprite3D/SubViewport/EnemyHP.set_value(health)
	damagesound.play()
	if health <= 0:
		
		die()
	pass 
