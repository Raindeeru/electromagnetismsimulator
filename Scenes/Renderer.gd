extends Node2D

@export var electric_field:ElectricField
var x_points_size: int
var y_points_size: int
var points_resolution = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _draw():
	var view_size = get_viewport().get_visible_rect().size
	print(view_size)
	x_points_size = view_size.x/points_resolution + 1
	y_points_size = view_size.y/points_resolution + 1
	
	for i in range(x_points_size):
		for j in range(y_points_size):
			var field_label = Label.new()
			add_child(field_label)
			field_label.set_position(Vector2(i*points_resolution, j*points_resolution))
			
			var field_vec = electric_field.get_electric_field(field_label.position)
			var field_mag = snappedf(sqrt(pow(field_vec.x, 2) + pow(field_vec.y, 2)), 0.01)
			var field_mag_reduced = min(50, field_mag/5000)
			var field_vec_redcuced = field_vec.normalized() * field_mag_reduced
			
			#arrow ends
			var angle1 = field_vec_redcuced.angle() + PI/2 + PI/4
			var angle2 = field_vec_redcuced.angle() - PI/2 - PI/4
			var normal_angle_vector1 = Vector2.from_angle(angle1)
			var normal_angle_vector2 = Vector2.from_angle(angle2)
			
			var arrow_end_1 = field_vec_redcuced + normal_angle_vector1 * field_mag_reduced/5
			
			var arrow_end_2 = field_vec_redcuced + normal_angle_vector2 * field_mag_reduced/5
			
			
			draw_line(field_label.position, field_label.position + field_vec_redcuced, Color.ALICE_BLUE, 1, true )
			draw_line(field_label.position + field_vec_redcuced, field_label.position + arrow_end_1, Color.ALICE_BLUE, 1, true)
			draw_line(field_label.position + field_vec_redcuced, field_label.position + arrow_end_2, Color.ALICE_BLUE, 1 , true)
			

func vector_magnitude(vec:Vector2):
	return sqrt(pow(vec.x, 2) + pow(vec.y, 2))
