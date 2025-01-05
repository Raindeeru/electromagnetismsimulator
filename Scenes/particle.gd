extends RigidBody2D
class_name Particle

#in microcoloumbs
@export var base_charge = 1
var charge:float = 1 
@export var charge_multiplier = Prefix.MICRO
@onready var base = $Base
@onready var positive = $Positive
@onready var negative = $Negative
var gradient:= Gradient.new()

signal edited
signal clicked(particle:Particle)

var particle_gradient := {
	0.0: Color.BLUE,
	0.5: Color.DARK_SLATE_GRAY,
	1.0: Color.RED
}

# Called when the node enters the scene tree for the first time.
func _ready():
	gradient.offsets = particle_gradient.keys()
	gradient.colors = particle_gradient.values()
	charge = base_charge * charge_multiplier
	var color_remapped = remap(charge, -1, 1, 0, 1)
	if (charge > 0):
		positive.visible = true
		negative.visible = false
	if (charge < 0):
		negative.visible = true
		positive.visible = false
	base.self_modulate = gradient.sample(color_remapped)
	

func teleport_particle(new_position: Vector2):
	PhysicsServer2D.body_set_state(
	get_rid(),
	PhysicsServer2D.BODY_STATE_TRANSFORM,
	Transform2D.IDENTITY.translated(new_position)
	)
	edited.emit()

func change_charge(new_charge:float, new_multiplier:float):
	base_charge = new_charge
	charge_multiplier = new_multiplier
	charge = base_charge * charge_multiplier
	
	var color_remapped = remap(charge, -1, 1, 0, 1)
	if (charge > 0):
		positive.visible = true
		negative.visible = false
	elif (charge < 0):
		negative.visible = true
		positive.visible = false
	else:
		negative.visible = false
		positive.visible = false
	base.self_modulate = gradient.sample(color_remapped)
	edited.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_mouse"):
		clicked.emit(self)
