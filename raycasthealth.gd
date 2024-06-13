extends RayCast3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
var health = 25
signal bullet_hit()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if is_colliding():

		var target = get_collider()
		emit_signal("bullet_hit", target)
		if target.has_method("healthpack"):
			
			target.healthpack(health)
			$"../MeshInstance3D".hide
			await get_tree().create_timer(15).timeout
			$"../MeshInstance3D".show

	pass
