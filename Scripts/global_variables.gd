extends Node

@onready var selected_particle: Particle = null
@onready var moving_particle: Particle = null
var adding: bool 

var editing:bool
var move_ready: bool
var moving:bool

const square_size: float = 100
var zoom_level: float = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func transform_coordinates(scale_vector: Vector2):
	var basis_vectors = Vector2(square_size, -square_size)
	return scale_vector/(basis_vectors * zoom_level)

func transform_to_godot_coordinates(scale_vector: Vector2):
	var basis_vectors = Vector2(square_size, -square_size)
	return scale_vector * (basis_vectors * zoom_level)
