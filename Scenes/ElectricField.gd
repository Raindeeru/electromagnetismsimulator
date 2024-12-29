extends Node2D
class_name  ElectricField

const coloumb_constant:float = 8987551786.2
@onready var particles = get_children()
signal added_signal
signal particle_edited

@export var add_button:Button
@export var edit_button:Button
@export var move_button:Button
@export var lock_button:Button

var particle_ref = preload("res://Scenes/particle.tscn")

var mouse_on_field: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	for particle in get_children():
		particle.clicked.connect(on_particle_clicked)
		particle.edited.connect(on_particle_edited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalVariables.moving_particle != null:
		GlobalVariables.moving_particle.teleport_particle(get_global_mouse_position())

func _input(event):
	if GlobalVariables.adding and mouse_on_field and event.is_action_pressed("left_mouse"):
		var particle:Particle = particle_ref.instantiate()
		particle.position = get_global_mouse_position()
		add_child(particle)
		particles = get_children()
		GlobalVariables.adding = false
		add_button.button_pressed = false
		GlobalVariables.selected_particle = particle
		particle.edited.connect(on_particle_edited)
		particle.clicked.connect(on_particle_clicked)
		added_signal.emit()
	if GlobalVariables.moving_particle != null and mouse_on_field  and event.is_action_pressed("left_mouse"):
		GlobalVariables.moving_particle = null
		GlobalVariables.moving = false
		GlobalVariables.move_ready = false
		move_button.button_pressed = false
		

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


func _on_control_mouse_entered():
	mouse_on_field = true


func _on_control_mouse_exited():
	mouse_on_field = false

func on_particle_edited():
	particle_edited.emit()

func on_particle_clicked(particle:Particle):
	print("hello")
	if GlobalVariables.editing:
		GlobalVariables.selected_particle = particle
	if GlobalVariables.move_ready:
		GlobalVariables.move_ready = false
		GlobalVariables.moving_particle = particle
		GlobalVariables.moving = true
	

func _on_add_toggled(toggled_on):
	if toggled_on:
		GlobalVariables.selected_particle = null
		GlobalVariables.moving_particle = null
		
		GlobalVariables.editing = false
		GlobalVariables.move_ready = false
		GlobalVariables.moving = false
		
		edit_button.button_pressed = false
		move_button.button_pressed = false
	GlobalVariables.adding = toggled_on


func _on_edit_toggled(toggled_on):
	GlobalVariables.editing = toggled_on
	if GlobalVariables.editing:
		GlobalVariables.selected_particle = null
		GlobalVariables.moving_particle = null
		
		GlobalVariables.adding = false
		GlobalVariables.moving = false
		GlobalVariables.move_ready = false
		
		add_button.button_pressed = false
		move_button.button_pressed = false
	else:
		GlobalVariables.selected_particle = null


func _on_ok_button_pressed():
	edit_button.button_pressed = false


func _on_move_toggled(toggled_on):
	GlobalVariables.move_ready = toggled_on
	if GlobalVariables.move_ready:
		GlobalVariables.selected_particle = null
		GlobalVariables.moving_particle = null
		
		GlobalVariables.adding = false
		GlobalVariables.editing = false
		
		add_button.button_pressed = false
		edit_button.button_pressed = false
