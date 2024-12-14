extends Node2D
class_name  ElectricField

const coloumb_constant:float = 8987551786.2
@onready var particles = get_children()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func coloumbs_law(charge1:float, charge2:float, radius: float):
	return (charge1 * charge2 * coloumb_constant)/pow(radius, 2)

func get_electric_field(pos:Vector2):
	var net_field:Vector2
	
	var net_field_x
	var net_field_y
	for particle in particles:
		var r = pos.distance_to(particle.position)
		
		var a = particle.position.angle_to_point(pos)
		print(a)
		print(pos)
		var field = coloumbs_law(particle.charge, 1, r)
		
		net_field.x += cos(a) * field
		net_field.y += sin(a) * field
	return net_field
