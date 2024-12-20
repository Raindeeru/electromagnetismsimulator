extends Node2D
class_name  ElectricField

const coloumb_constant:float = 8987551786.2
@onready var particles = get_children()
signal added_signal

var particle_ref = preload("res://Scenes/particle.tscn")

var adding:bool
var mouse_on_field: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if adding and mouse_on_field and event.is_action_pressed("left_mouse"):
		var particle = particle_ref.instantiate()
		particle.position = get_global_mouse_position()
		add_child(particle)
		particles = get_children()
		adding = false
		added_signal.emit()

func coloumbs_law(charge1:float, charge2:float, radius: float):
	return (charge1 * charge2 * coloumb_constant)/pow(radius, 2)

func get_electric_field(pos:Vector2):
	var net_field:Vector2
	
	var net_field_x
	var net_field_y
	for particle in particles:
		var r = pos.distance_to(particle.position)
		
		var a = particle.position.angle_to_point(pos)
		var field = coloumbs_law(particle.charge, 1, r)
		
		net_field.x += cos(a) * field
		net_field.y += sin(a) * field
	return net_field

func _on_add_pressed():
	if adding:
		adding = false
	else:
		adding = true



func _on_control_mouse_entered():
	mouse_on_field = true


func _on_control_mouse_exited():
	mouse_on_field = false
