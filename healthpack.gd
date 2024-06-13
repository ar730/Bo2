extends Node3D

@onready var animspawnhpbox = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	animspawnhpbox.play("floathppach2")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
