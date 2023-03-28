extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_die_02_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		Globals.boulder_die = 1
		get_tree().change_scene_to_file("res://game.tscn")


func _on_die_01_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		Globals.boulder_die = 0
		get_tree().change_scene_to_file("res://game.tscn")
