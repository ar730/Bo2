extends CharacterBody3D
# Инициализация и предзагрузка ссылок переменных
@onready var _animated_model = $Walking/AnimationPlayer
@onready var _gun_anim = $head/Node3D/gun/AnimGun
@onready var _hiet = $AudioStreamPlayer
@onready var _toptop = $AudioStreamPlayer2
@onready var _musicplay = $AudioStreamPlayer3
@warning_ignore("unused_private_class_variable")
@onready var _walkcam = $head/Node3D/MeshInstance3D/AnimationPlayer
@onready var bullet2 = preload("res://bullet_2.tscn")
@onready var bullet_spawn_point = $head/bulletspawn
@onready var damagesound = $damagesound
@onready var joinsound1 = $joinsound
@onready var mainsound = $mainsound
@onready var shootsound = $shootsound
@onready var Failsound = $FailSound
@onready var head = $head
@onready var camera = $head/Camera3D
@onready var cameraaim = $head/Node3D/MeshInstance3D/Camera3D2
@onready var gun_barrel = $head/Node3D/gun/RayCast3D

#Обьявление переменных внутри скрипта
var healthPlayer = 100
var acceptshoot = 0
var cyclegrounded = 0
var SPEED = 7.0
var jumpscore = 0
const JUMP_VELOCITY = 5.0
var mouse_sense = 0.1
var lastanimstate = 0
var lastanim = 0
var i = 0
var bulletspeed = 25
var firstperson = 0
var bullet = load("res://import assets/Vector/bullet.tscn")
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var instance



func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) #Блокировка курсора внутри окна
	joinsound1.play() #Старт музыки
	await get_tree().create_timer(4).timeout
	mainsound.play()#Старт музыки

func _input(event):

	#Ограничение угла поворота камеры
	if event is InputEventMouseMotion:
		if firstperson == 0:
			rotate_y(deg_to_rad(-event.relative.x * mouse_sense))
			head.rotate_x(deg_to_rad(-event.relative.y * mouse_sense))
			head.rotation.x = clamp(head.rotation.x, deg_to_rad(-30), deg_to_rad(30))
		
		else:
			rotate_y(deg_to_rad(-event.relative.x * mouse_sense))
			head.rotate_x(deg_to_rad(-event.relative.y * mouse_sense))
			head.rotation.x = clamp(head.rotation.x, deg_to_rad(-85), deg_to_rad(85))
	$head/Node3D/MeshInstance3D/Camera3D2.set_current(true)
	firstperson = 1 
	$Walking.hide()

# Вызов пули и анимации стрельбы
	if Input.is_action_just_pressed("shoot"):
		acceptshoot = 1
		shootsound.play()
		spawn_bullet()
		Global.sprayfire = true
	elif Input.is_action_just_released("shoot"):
		_gun_anim.stop()
		Global.sprayfire = false
		acceptshoot = 0
	if Global.sprayfire == true:
		_gun_anim.play("firegun")
		await get_tree().create_timer(0.5).timeout
		_gun_anim.stop()
		
# Получение урона
func take_damage_player(amount):
	healthPlayer -= amount
	$ProgressBar.set_value(healthPlayer)
	damagesound.play()
	if healthPlayer <= 0:
		die()
# Реализация аптечки
func healthpack(amount):
	if healthPlayer < 100:
		healthPlayer += amount
	if healthPlayer > 100:
		healthPlayer = 100
	$ProgressBar.set_value(healthPlayer)
func die():
	# Логика смерти
	Failsound.play()
	await get_tree().create_timer(5).timeout
	get_tree().change_scene_to_file("res://menu.tscn") # загрузка меню при смерти
	pass

func _process(delta):

	pass
# Появление пули
func spawn_bullet():
	var projectile = bullet2.instantiate()
	add_sibling(projectile)
	projectile.transform = bullet_spawn_point.global_transform
	projectile.linear_velocity = bullet_spawn_point.global_transform.basis.z * -1 * bulletspeed

# Гравитация
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta


	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY	
		jumpscore = 0
		_hiet.play()
		cyclegrounded = 0

	if Input.is_action_just_pressed("ui_accept") and not is_on_floor() :
		if jumpscore == 0:
			_hiet.play()
			velocity.y = JUMP_VELOCITY	
			jumpscore = 1
	if is_on_floor() and cyclegrounded == 0:

		cyclegrounded = 1
	if not is_on_floor():

		cyclegrounded = 0
	elif Input.is_action_just_pressed("forward"):
		_animated_model.play("mixamo_com")
	elif Input.is_action_just_released("forward"):
		_animated_model.pause()
	elif Input.is_action_just_pressed("run"):
		_toptop.play()
		if is_on_floor():
			SPEED = 12.0
			
	elif Input.is_action_just_released("run"):
		SPEED = 7.0

	
# Код перемещения игрока
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)


	move_and_slide()







