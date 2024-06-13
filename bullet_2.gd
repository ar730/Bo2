
extends Node3D


var speed = 100  # Скорость пули
var damage = 10   # Урон от пули
@onready var RayBullet1 = $RayCast3D
func _physics_process(delta):
	
	pass


#func _physics_process(delta):
#
##	var collision = move_and_collide()
##	if collision:
##		# Если пуля столкнулась с объектом
##		var target = collision.collider
##		aa
##		queue_free()  # Уничтожаем пулю после попадания

#
## Called when the node enters the scene tree for the first time.
#func _ready():
#
#	pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
#
#
func _on_timer_timeout():
	queue_free()
	pass # Replace with function body.
#
#
#func _on_area_3d_body_entered(Player):
#	print(Global.count)
#	Global.count = Global.count + 1
#	pass # Replace with function body.
