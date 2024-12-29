extends Node2D
class_name Renderer

@export var electric_field:ElectricField
@export var camera:Camera2D
@export var render_vector_field:bool = true
var x_points_size: int
var y_points_size: int
var points_resolution = 50

var gradient_data := {
	0.0: Color.BLACK,
	0.20: Color.WEB_PURPLE,
	0.5: Color.RED,
	0.70: Color.YELLOW,
	1.0: Color.WHITE
}
@onready var gradient := Gradient.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	gradient.offsets = gradient_data.keys()
	gradient.colors = gradient_data.values()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _draw():
	if !render_vector_field:
		return
	var view_size = get_viewport().get_visible_rect().size
	x_points_size = view_size.x/points_resolution + 1
	y_points_size = view_size.y/points_resolution + 1
	
	var camera_position = camera.get_screen_center_position() - get_viewport().get_visible_rect().size
	var max = 0
	
	for i in range(x_points_size + 2):
		for j in range(y_points_size + 2):
			var field_label = Label.new()
			add_child(field_label)
			field_label.set_position(Vector2((i - 1) *points_resolution, (j - 1)*points_resolution) + camera_position/2)
			
			
			var field_vec = electric_field.get_electric_field(field_label.position)
			var field_mag = snappedf(sqrt(pow(field_vec.x, 2) + pow(field_vec.y, 2)), 0.01)
			var field_mag_reduced = min(30, field_mag/5000)
			var field_vec_redcuced = field_vec.normalized() * field_mag_reduced
			#arrow ends
			var angle1 = field_vec_redcuced.angle() + PI/2 + PI/4
			var angle2 = field_vec_redcuced.angle() - PI/2 - PI/4
			var normal_angle_vector1 = Vector2.from_angle(angle1)
			var normal_angle_vector2 = Vector2.from_angle(angle2)
			
			var arrow_end_1 = field_vec_redcuced + normal_angle_vector1 * field_mag_reduced/5
			
			var arrow_end_2 = field_vec_redcuced + normal_angle_vector2 * field_mag_reduced/5
			
			var scaled_point = log(field_mag)/log(2)
			
			var mapped_point = remap(scaled_point, 13, 25, 0, 1)
			
			var arrow_color = gradient.sample(mapped_point)
			
			draw_line(field_label.position, field_label.position + field_vec_redcuced, arrow_color, 1, true )
			draw_line(field_label.position + field_vec_redcuced, field_label.position + arrow_end_1, arrow_color, 1, true)
			draw_line(field_label.position + field_vec_redcuced, field_label.position + arrow_end_2, arrow_color, 1 , true)
			
			
			if scaled_point > max:
				max = scaled_point
		

func vector_magnitude(vec:Vector2):
	return sqrt(pow(vec.x, 2) + pow(vec.y, 2))


func _on_electric_field_added_signal():
	queue_redraw()



func _on_electric_field_particle_edited():
	queue_redraw()


func _on_check_box_toggled(toggled_on):
	render_vector_field = toggled_on
