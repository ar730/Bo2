extends RayCast3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
var damage = 0.1
var idPlayer = "player"
const Player = preload("res://player.gd")
signal bullet_hit()

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(_delta):
	
	if is_colliding():

		var target = get_collider()

		var transiateTarget = str(target)

		emit_signal("bullet_hit",target)
		await get_tree().create_timer(0.1).timeout
		if idPlayer in transiateTarget:
#			if target.has_method("take_damage_player"):
			target.take_damage_player(damage)
	pass

 
