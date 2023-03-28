extends RigidBody3D

var boulder_die =  1
var result_text = [{
	"Affe": "[b]Affe - Ohne Füße[/b]\nJetzt hangelst du dich ohne Füße von Boulder zu Boulder. Ab geht’s in den Überhang.",
	"Rakete": "[b]Rakete - Schnelligkeit[/b]\nJetzt aber richtig schnell rauf! Ich zähle bis 3 und du bist hoffentlich schon oben!",
	"Haende": "[b]Hände - Handgriff doppeln[/b]\nJeden Stein mit beiden Händen greifen! Denk daran tief unter dem Stein zu stehen.", 
	"Schnecke": "[b]Schnecke - Schneckentempo[/b]\nLangsames Klettern trainiert deine Körperspannung und hilft dir sauberer zu Treten und zu Greifen.", 
	"Chamaeleon": "[b]Chamäleon - Schreckstarre[/b]\nWarte ein paar Sekunden vor jedem Handgriff und schau ihn dir genau an, bevor du ihn greifst.", 
	"KeineHand": "[b]Hand Durchgestrichen - Ohne Hände[/b]\nWirklich ohne Hände. Wo ist die nächste positive Wand? Achte auf deine Balance."
}, 
{
	"Affe": "[b]Affe - Füße von der Wand[/b]\nZeig was in deinen Armen steckt! Und baumel so lange bis die nächste Anweisung kommt.",
	"Rakete": "[b]Linker Fuß - Weitester linker Fußtritt[/b]\nHoffentlich ist deine Position bequem und du kannst den linken Fuß ganz weit setzen!",
	"Haende": "\n[b]Linke Hand - Weitester linker Handgriff[/b]\nStreck dich ganz lang nach links und greif zu!", 
	"Schnecke": "[b]Hände überkreuzt - Hände kreuzen[/b]\nAn der Wand wirst du merken, wie froh du über die Anweisung Hände kreuzen sein wirst.", 
	"Chamaeleon": "\n[b]Rechter Fuß - Weitester rechter Fußtritt[/b]\nNa wie weit kommst du mit deinem rechten Bein?", 
	"KeineHand": "[b]Rechte Hand - Weitester rechter Handgriff[/b]\nMach Meter mit deiner rechten Hand, damit du von der Stelle kommst!"
}
]

# Called when the node enters the scene tree for the first time.
func _ready():
	boulder_die =  Globals.boulder_die
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if boulder_die == 0:
		get_node("CollisionShape3D/BoulderDie02").set_visible(false)
		get_node("CollisionShape3D/BoulderDie01").set_visible(true)
	else:
		get_node("CollisionShape3D/BoulderDie02").set_visible(true)
		get_node("CollisionShape3D/BoulderDie01").set_visible(false)

func _input(event):
	if event.is_action_pressed("click"):
		get_node("%Result_Label").set_visible(false)
		var _mypos = get_global_position()
		apply_impulse(Vector3(-_mypos.x + randf_range(-1, 1), randf_range(6, 9), -_mypos.z + randf_range(-1, 1)))
		apply_torque_impulse(Vector3(randf_range(1, 6.2)*random_sign(), randf_range(1, 6.2)*random_sign(), randf_range(1, 6.2)*random_sign()))
		get_node("%Camera").set_camera_state(1)
	if event.is_action_pressed("back"):
		get_tree().change_scene_to_file("res://menu.tscn")

func _integrate_forces(state):
	if state.get_linear_velocity().length_squared() < 0.00000001: 
		# print(state.get_linear_velocity().length_squared())
		state.linear_velocity = Vector3.ZERO
		state.angular_velocity = Vector3.ZERO
		# reset to center position
		# print(state.transform.origin)
		# state.transform.origin = Vector3(0.0, 0.5, 0.0)
		# state.transform.basis = state.transform.basis.rotated(Vector3.UP,0.0)
		# print(round(get_global_rotation_degrees()))
		var _rot = get_global_rotation_degrees()
		get_node("%Result_Label").set_visible(true)
		if abs(round(_rot.x)) < 2:  # rotation x in degrees is 0
			if abs(round(_rot.z)) < 2:
				print("Chamaeleon")
				get_node("%Result_Label").set_text(result_text[boulder_die]["Chamaeleon"])
			if abs(round(_rot.z) - 90) < 2:
				print("Schnecke")
				get_node("%Result_Label").set_text(result_text[boulder_die]["Schnecke"])
			if abs(round(_rot.z) + 90) < 2:
				print("Rakete")
				get_node("%Result_Label").set_text(result_text[boulder_die]["Rakete"])
			if int(abs(round(_rot.z) + 180))%360 < 2:
				print("Affe")
				get_node("%Result_Label").set_text(result_text[boulder_die]["Affe"])
		else:  # rotation x in degrees is not 0
			if abs(round(_rot.x) - 90) < 2:
				print("Haende")
				get_node("%Result_Label").set_text(result_text[boulder_die]["Haende"])
			if abs(round(_rot.x) + 90) < 2:
				print("KeineHand")
				get_node("%Result_Label").set_text(result_text[boulder_die]["KeineHand"])
		get_node("%Camera").set_camera_state(0)
		get_node("%Camera").set_position_in(state.transform.origin)
		
func random_sign():
	if randf() < 0.5:
		return -1
	else:
		return 1
