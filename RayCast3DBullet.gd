extends RayCast3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
var damage = 25
signal bullet_hit()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if is_colliding():
		if Input.is_action_just_pressed("shoot"):
			var target = get_collider()

			emit_signal("bullet_hit", target)
			if target.has_method("take_damage"):
				target.take_damage(damage)

	pass
