extends Node3D

var _rotation = Vector3(0.0, 0.0, 0.0)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_rotation.y += 0.33
	set_rotation_degrees(_rotation)

	pass
