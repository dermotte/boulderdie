extends Camera3D

var position_out = Vector3(0.0, 7.0, 0.0)
var position_in = Vector3(0.0, 2.0, 0.0)
var _pos = Vector3(0.0, 2.0, 0.0)

var camera_state = 0 # 0 .. zoomed in, 1 .. zoomed out
var animation = 0.0

var ease_weight = 0.2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if animation < 1.0:
		animation += 0.01
		if camera_state == 0:
			_pos = position_out.slerp(position_in, ease(animation, ease_weight))
		else: 
			_pos = position_in.slerp(position_out, ease(animation, ease_weight))
	set_global_position(_pos)

func set_camera_state(new_state):
	if camera_state != new_state:
		camera_state = new_state
		animation = 0;
		
func set_position_in(new_position_in):
	position_in = new_position_in
	position_in.y = 2.0
