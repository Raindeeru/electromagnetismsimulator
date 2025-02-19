GDPC                @
                                                                         T   res://.godot/exported/133200997/export-0271e18ecf37a36b455ad0b215994549-world.scn   �=      y#      1�'a6:�ͷ,5?)�>    X   res://.godot/exported/133200997/export-26e8a97d9ee22129de24c65c08ff6508-rounded_box.res         �      ��nϦ0�� &`�<��V    T   res://.godot/exported/133200997/export-5e82850bd5753431b145711405557c1b-world.res   �      R      ����R�9�⌥�M�    T   res://.godot/exported/133200997/export-d1da9c91939224f652d8c3836bad4a25-particle.scn�&      �      �(zO%�=ܼs&�    `   res://.godot/exported/133200997/export-e1f80c2eb4073548ce7c24a0a8e7fcb6-position_control_box.scn�-      �      �x�h4�=A����j,t    ,   res://.godot/global_script_class_cache.cfg  ~      �      B�e���*����:U    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex n      �      �̛�*$q�*�́     H   res://.godot/imported/negative.png-c9cceeac55f53bdc5979c1b835a20e87.ctex�c      �      �����*߇QK�g"    P   res://.godot/imported/particle_base.png-d7de343c256994d18c16f11307053e1a.ctex   @f      H      �w��n3����S�6�    H   res://.godot/imported/positive.png-06e9d490943de57b3a436ca5569e8ec6.ctex`j      �      ��nC4�i����h�6�       res://.godot/uid_cache.bin  p�      b      /s� �(ć�>�GEL�    (   res://Resources/rounded_box.tres.remap  �{      h       N rBl�@�zR����        res://Resources/world.tres.remap@|      b       �2B挄)��p+�&�       res://Scenes/Charge Edit.gd �            XC�8Ӟ��"��D'C        res://Scenes/ElectricField.gd          h      ���܋�"OB&��    $   res://Scenes/PositionControlBox.gd  `,            ���Ĕޱ�g ��       res://Scenes/Renderer.gd`1      �
      �� �9� �r��&        res://Scenes/SpinBoxPosition.gd @<      V      1e�kl<�{�J=q       res://Scenes/particle.gdp       F      �l��C�&1�
�'��        res://Scenes/particle.tscn.remap�|      e       7�%�T@�#y�~hN4    ,   res://Scenes/position_control_box.tscn.remap }      q       ����ȸt�j6�3�
z        res://Scenes/world.tscn.remap   �}      b        �!�I��)%�a�    $   res://Scripts/global_variables.gd    a      �      Jla)r�����FRH    $   res://Sprites/negative.png.import   pe      �       ��=k1U�2�A��X��    (   res://Sprites/particle_base.png.import  �i      �       ����~�l��Cv�*    $   res://Sprites/positive.png.import   Pm      �       ��
����K�Pt����       res://icon.svg  ��      �      C��=U���^Qu��U3       res://icon.svg.import    {      �       (';�B�c�I� �De       res://project.binary��      N      �r!ꈔ^�媏��    RSRC                    StyleBoxFlat            ��������                                                  resource_local_to_scene    resource_name    content_margin_left    content_margin_top    content_margin_right    content_margin_bottom 	   bg_color    draw_center    skew    border_width_left    border_width_top    border_width_right    border_width_bottom    border_color    border_blend    corner_radius_top_left    corner_radius_top_right    corner_radius_bottom_right    corner_radius_bottom_left    corner_detail    expand_margin_left    expand_margin_top    expand_margin_right    expand_margin_bottom    shadow_color    shadow_size    shadow_offset    anti_aliasing    anti_aliasing_size    script           local://StyleBoxFlat_6ehew          StyleBoxFlat          
�t>��,>���>  �?                                          
         RSRC  RSRC                    StyleBoxFlat            ��������                                                  resource_local_to_scene    resource_name    content_margin_left    content_margin_top    content_margin_right    content_margin_bottom 	   bg_color    draw_center    skew    border_width_left    border_width_top    border_width_right    border_width_bottom    border_color    border_blend    corner_radius_top_left    corner_radius_top_right    corner_radius_bottom_right    corner_radius_bottom_left    corner_detail    expand_margin_left    expand_margin_top    expand_margin_right    expand_margin_bottom    shadow_color    shadow_size    shadow_offset    anti_aliasing    anti_aliasing_size    script           local://StyleBoxFlat_tg4na          StyleBoxFlat          
�t>��,>���>  �?      RSRC              extends MarginContainer

@export var renderer:Renderer

@onready var charge_slider = $"Panel/VBoxContainer/Charge/ChargeLabel/Chargeslider/HSlider"
@onready var charge_value = $"Panel/VBoxContainer/Charge/ChargeLabel/ChargeValue"

@onready var x_position:SpinBoxPosition = $"Panel/VBoxContainer/Position/HBoxContainer/XBox/SpinBoxX"
@onready var y_position:SpinBoxPosition = $"Panel/VBoxContainer/Position/HBoxContainer/YBox/SpinBoxY"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalVariables.selected_particle != null:
		visible = true
	else:
		visible = false


func _on_ok_button_pressed():
	GlobalVariables.selected_particle = null


func _on_panel_gui_input(event):
	if event is InputEventScreenDrag:
		position += event.relative


func _on_h_slider_visibility_changed():
	if GlobalVariables.selected_particle != null:
		charge_slider.value = GlobalVariables.selected_particle.charge


func _on_h_slider_value_changed(value):
	charge_value.value = value
	if value >= -1 && value <= 1:
		GlobalVariables.selected_particle.change_charge(value)

func _on_charge_value_value_changed(value):
	charge_slider.value = value
	GlobalVariables.selected_particle.change_charge(value)

func _on_spin_box_x_visibility_changed():
	if GlobalVariables.selected_particle != null:
		x_position.godot_coordinates_position = GlobalVariables.selected_particle.position.x
		x_position.grid_coordinates_position = GlobalVariables.transform_coordinates(GlobalVariables.selected_particle.position).x
		x_position.value = x_position.grid_coordinates_position

func _on_spin_box_y_visibility_changed():
	if GlobalVariables.selected_particle != null:
		y_position.godot_coordinates_position = GlobalVariables.selected_particle.position.y
		y_position.grid_coordinates_position = GlobalVariables.transform_coordinates(GlobalVariables.selected_particle.position).y
		y_position.value = y_position.grid_coordinates_position


func _on_spin_box_x_value_changed(value):
	if GlobalVariables.transform_coordinates(Vector2(x_position.grid_coordinates_position,0)).x == value:
		return
	var new_x = GlobalVariables.transform_to_godot_coordinates(Vector2(value,0)).x
	GlobalVariables.selected_particle.teleport_particle(Vector2(new_x, GlobalVariables.selected_particle.position.y))
	renderer.queue_redraw()

func _on_spin_box_y_value_changed(value):
	if GlobalVariables.transform_coordinates(Vector2(0,y_position.grid_coordinates_position)).y == value:
		return
	var new_y = GlobalVariables.transform_to_godot_coordinates(Vector2(0,value)).y
	GlobalVariables.selected_particle.teleport_particle(Vector2(GlobalVariables.selected_particle.position.x, new_y))
	renderer.queue_redraw()

    extends Node2D
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
        extends RigidBody2D
class_name Particle

#in microcoloumbs
@export var charge:float = 1 
@onready var base = $Base
@onready var positive = $Positive
@onready var negative = $Negative
const microcoloumb = 0.000001
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

func change_charge(new_charge:float):
	charge = new_charge
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
          RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    radius    script 	   _bundled       Script    res://Scenes/particle.gd ��������
   Texture2D     res://Sprites/particle_base.png ��נ�3�
   Texture2D    res://Sprites/positive.png ���	�]�\
   Texture2D    res://Sprites/negative.png '��)�шo      local://CircleShape2D_3tyg4 �         local://PackedScene_j0m66 (         CircleShape2D            �A         PackedScene          	         names "      	   Particle    input_pickable    gravity_scale    script    RigidBody2D    Base    scale    texture 	   Sprite2D    CollisionShape2D    shape 	   Positive    visible 	   Negative    _on_input_event    input_event    	   variants    
                          
   6�>6�>                          
   ��u>��u>                        node_count             nodes     ;   ��������       ����                                        ����                           	   	   ����   
                        ����                                       ����                  	             conn_count             conns                                       node_paths              editable_instances              version             RSRC               extends HBoxContainer
class_name PositionControlBox


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
            RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script #   res://Scenes/PositionControlBox.gd ��������      local://PackedScene_vrubo          PackedScene          	         names "         XBox    size_flags_horizontal    script    HBoxContainer    Label    layout_mode    text 	   SpinBoxX 
   min_value 
   max_value    SpinBox    Label2    	   variants                                          X    �#t�   �#tI      m       node_count             nodes     2   ��������       ����                                  ����                                 
      ����               	                        ����                               conn_count              conns               node_paths              editable_instances              version             RSRCextends Node2D
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
             extends SpinBox
class_name SpinBoxPosition

var grid_coordinates_position: float
var godot_coordinates_position: float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
          RSRC                    PackedScene            ��������                                            p      ..    ElectricField 	   Camera2D    CanvasLayer    Control    Screen    Particle Controls    MarginContainer    Vbox    Add    Edit    Move    Lock 	   Renderer    resource_local_to_scene    resource_name    background_mode    background_color    background_energy_multiplier    background_intensity    background_canvas_max_layer    background_camera_feed_id    sky    sky_custom_fov    sky_rotation    ambient_light_source    ambient_light_color    ambient_light_sky_contribution    ambient_light_energy    reflected_light_source    tonemap_mode    tonemap_exposure    tonemap_white    ssr_enabled    ssr_max_steps    ssr_fade_in    ssr_fade_out    ssr_depth_tolerance    ssao_enabled    ssao_radius    ssao_intensity    ssao_power    ssao_detail    ssao_horizon    ssao_sharpness    ssao_light_affect    ssao_ao_channel_affect    ssil_enabled    ssil_radius    ssil_intensity    ssil_sharpness    ssil_normal_rejection    sdfgi_enabled    sdfgi_use_occlusion    sdfgi_read_sky_light    sdfgi_bounce_feedback    sdfgi_cascades    sdfgi_min_cell_size    sdfgi_cascade0_distance    sdfgi_max_distance    sdfgi_y_scale    sdfgi_energy    sdfgi_normal_bias    sdfgi_probe_bias    glow_enabled    glow_levels/1    glow_levels/2    glow_levels/3    glow_levels/4    glow_levels/5    glow_levels/6    glow_levels/7    glow_normalized    glow_intensity    glow_strength 	   glow_mix    glow_bloom    glow_blend_mode    glow_hdr_threshold    glow_hdr_scale    glow_hdr_luminance_cap    glow_map_strength 	   glow_map    fog_enabled    fog_light_color    fog_light_energy    fog_sun_scatter    fog_density    fog_aerial_perspective    fog_sky_affect    fog_height    fog_height_density    volumetric_fog_enabled    volumetric_fog_density    volumetric_fog_albedo    volumetric_fog_emission    volumetric_fog_emission_energy    volumetric_fog_gi_inject    volumetric_fog_anisotropy    volumetric_fog_length    volumetric_fog_detail_spread    volumetric_fog_ambient_inject    volumetric_fog_sky_affect -   volumetric_fog_temporal_reprojection_enabled ,   volumetric_fog_temporal_reprojection_amount    adjustment_enabled    adjustment_brightness    adjustment_contrast    adjustment_saturation    adjustment_color_correction    script 	   _bundled       Script    res://Scenes/Renderer.gd ��������   Script    res://Scenes/ElectricField.gd ��������   PackedScene    res://Scenes/particle.tscn ��V��3�c	   StyleBox    res://Resources/world.tres �i\ߕ?   Script    res://Scenes/Charge Edit.gd ��������	   StyleBox !   res://Resources/rounded_box.tres ��5t��   Script     res://Scenes/SpinBoxPosition.gd ��������      local://Environment_ii7jf ^         local://PackedScene_3eux4 �         Environment             @         L      \�B>M         n         PackedScene    o      	         names "   g      World    Node2D 	   Renderer    script    electric_field    camera    ElectricField    add_button    edit_button    move_button    lock_button 
   Particle5    CanvasLayer    Control    layout_mode    anchors_preset    offset_right    offset_bottom    mouse_filter    mouse_default_cursor_shape    Screen    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    HBoxContainer    Particle Controls    custom_minimum_size    theme_override_styles/panel    Panel    MarginContainer %   theme_override_constants/margin_left $   theme_override_constants/margin_top    Vbox    size_flags_vertical    VBoxContainer    Add    size_flags_horizontal    toggle_mode    text    Button    Move    Edit    Lock 	   CheckBox    button_pressed 	   FieldBox    Charge Edit &   theme_override_constants/margin_right '   theme_override_constants/margin_bottom 	   renderer    Charge    ChargeLabel $   theme_override_constants/separation    Label    Chargeslider    HSlider 
   min_value 
   max_value    step    size_flags_stretch_ratio    Label2 	   Control2    Label3    ChargeValue    SpinBox 	   Position    XBox 	   SpinBoxX    YBox 	   SpinBoxY    Ok 	   OkButton 	   Camera2D    offset    WorldEnvironment    environment     _on_electric_field_added_signal    added_signal #   _on_electric_field_particle_edited    particle_edited    _on_add_toggled    toggled    _on_move_toggled    _on_edit_toggled    _on_check_box_toggled    _on_control_mouse_entered    mouse_entered    _on_control_mouse_exited    mouse_exited    _on_panel_gui_input 
   gui_input    _on_h_slider_value_changed    value_changed     _on_h_slider_visibility_changed    visibility_changed    _on_charge_value_value_changed    _on_spin_box_x_value_changed "   _on_spin_box_x_visibility_changed    _on_spin_box_y_value_changed "   _on_spin_box_y_visibility_changed    _on_ok_button_pressed    pressed    	   variants    :                                                                            	                               
                                                                                           ��D     "D                 �?      
     �B                
        �C
         �B      
     �B  �B                  Add
       Move       Edit       Lock       Draw Field      �C     NC                                               
          B      Charge      ��)   {�G�z�?     @?      -1       0
       1      ��      C             X
    �#t�   �#tI)   ����MbP?               m       Y 
     �B          OK 
     ��                    node_count    .         nodes     �  ��������       ����                      ����            @     @                     ����           @     @   	  @   
  @              ���                            ����                     ����      	      
                        	                    ����                                                        ����                                      ����                                                         #   !   ����               "          	       (   $   ����               %   
   "      &      '          	       (   )   ����               %   
   "      &      '          	       (   *   ����               %   
   "      &      '          	       (   +   ����               %   
   "      '          	       ,   ,   ����         -      '                    .   ����         %   	                       /   ����	      
                             0      1         !   2  @"                    ����            #              #   #   ����                                                     3   ����         %   	                0      1                    4   ����      $         5                 6   6   ����         %   
   '   %              #   7   ����         %   	              8   8   ����         %   	   "      9   &   :      ;   '                    ����         <   (              6   6   ����         '   )                    ����         %   	              6   =   ����         %      '   *                 >   ����         %   	              6   ?   ����         %      '   +              A   @   ����         9   ,   ;   '              6   =   ����         %   
   '   -                 B   ����         %   	                0      1                        ����      $         5   .       !          C   ����         %   	       "       6   6   ����         %   
   '   /       "       A   D   ����         9   0   :   1   ;   2      3       "       6   =   ����         %   
   '   4       !          E   ����         %   	       &       6   6   ����         %   
   '   5       &       A   F   ����         9   0   :   1   ;   2      3       &       6   =   ����         %   
   '   4                 G   ����      6         %                   0      1          *       (   H   ����         '   7               I   I   ����   J   8               K   K   ����   L   9             conn_count             conns     ~         N   M                    P   O              
      R   Q                    R   S                    R   T                    R   U                    W   V                    Y   X                    [   Z                    ]   \                    _   ^                    ]   `              $      ]   a              $      _   b              (      ]   c              (      _   d              +      f   e              +      f   e                    node_paths              editable_instances              version       n      RSRC       extends Node

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
     GST2   d   d      ����               d d        \  RIFFT  WEBPVP8LG  /c�۶�$]�M�Yo�/nm퍢?P4%`s�) �4��'�������Ӷ@� ��Ff�F��6J�M��跐���P-w�� *��(5=c����:�c�3ȗ�% �1��'Ľ���c�61�S��"df�(�j(���lA29ˏPQ�g�Vz^+���pm�3�������W�?���CPUR𡓠��t��Lp��Q� ʙ�:!q��8"rF�3:��#m�B�&x�>�-FHζIҟ$3cŢ&����l�+)5]#���(]��> �/�X`Ƹ<��v6�X�0�U�Z1��hC�Xڰ4�Wȋ              [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://dmrevvcc5xtpf"
path="res://.godot/imported/negative.png-c9cceeac55f53bdc5979c1b835a20e87.ctex"
metadata={
"vram_texture": false
}
            GST2   d   d      ����               d d          RIFF  WEBPVP8L�  /c��6�I��<�U���pd[[ۼ�J�f~e���(���
�](�IgX�V�6�I�	��L��|��6�$�6=멫��a90^ڨ1�5�.�2^]:�F2fT�|8�D�!UWh)�Ti��&n���B1&��ʅ)�EbWk���:���8:!e&:��P�sc3�B��2���ХF/]U���812�2O���{C��M���pf�՘��n��&�X�����q*P�<I�( %j��"�K�z�-��\��G�����)w��&����̠����=y�Q;oy�j���fl�EF�5�ژG�1�b�b	v�Ql�<�\LBe�r�ђѰ�"����n6;q����Q�Q�hE��`(�A �|* ��<z x�H}�c/ �^@����_���\x}���ox��?��z���3�g��)�/�¿�\�s	��O�P>� Z�i J:
�1���'�N���f��F-��d���a�b*PΥ!V*�`̧2-6j&wl=ГI7>jȉ�j��������|���Ic��8�Yl��&��i'�
x�ၿټ��S��h�R]�B��n��#�+�j��5�n��q��b�6�3}�-��U�����&�v�s��O&�ۯ=�����;q��c��2��_�
�J̓�J���`��2��eLv���`G�^�#R�P�b0��@�A�k\��0�� /e�H��ȅ:݋GVID#R\ ��         [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://vnf60csxjx7r"
path="res://.godot/imported/particle_base.png-d7de343c256994d18c16f11307053e1a.ctex"
metadata={
"vram_texture": false
}
        GST2   d   d      ����               d d        �  RIFF�  WEBPVP8L�  /c��a m��7��71��ϸ�$Ź�2?/r@Fō���H�  *
���(�xp�$d$ @D t���D��[�W`!��x��\���n9��Bmo޽���˄�u�_H`p�Roa�N��iթB���K�ە�3�j��٧��A\wo[Tbͭ[.0�2����"�=^�� �^]S��i�Em����g{xFE@�x�!&x�X1<,D(�1��<��*��&��!��� ��!�j��ː!~�� G��f�~/H��K��4�7SuM[��8�c��v/��>��K���)*���Yͧ�e�x�oQOy�3��&.W����]�(m@�Cu+U5��W���j���m���������չ�2���Y�'��^����d�Ƀ�������!�q�$���w����o�����[LHW�־�)�Jg*z��YZ��jh�7�LX��b��.��R�Å����^׏�Br�?l��26�{-JHU��	!H3I���x�Kx#[M0G�h�D�&��+��!C�(��X~��(����؇��ن��Y�X�Y�X�a!؟!Ó�(L���0
1��w�lO+����P��8E���մ�@�2��*ED����<��uIZ��<�s�i�uPi8�}��R��6� ,�Y���ӪC���J�/	l�-��$�%	         [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://c2edp2dhnvuiy"
path="res://.godot/imported/positive.png-06e9d490943de57b3a436ca5569e8ec6.ctex"
metadata={
"vram_texture": false
}
            GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح�m�m������$$P�����එ#���=�]��SnA�VhE��*JG�
&����^x��&�+���2ε�L2�@��		��S�2A�/E���d"?���Dh�+Z�@:�Gk�FbWd�\�C�Ӷg�g�k��Vo��<c{��4�;M�,5��ٜ2�Ζ�yO�S����qZ0��s���r?I��ѷE{�4�Ζ�i� xK�U��F�Z�y�SL�)���旵�V[�-�1Z�-�1���z�Q�>�tH�0��:[RGň6�=KVv�X�6�L;�N\���J���/0u���_��U��]���ǫ)�9��������!�&�?W�VfY�2���༏��2kSi����1!��z+�F�j=�R�O�{�
ۇ�P-�������\����y;�[ ���lm�F2K�ޱ|��S��d)é�r�BTZ)e�� ��֩A�2�����X�X'�e1߬���p��-�-f�E�ˊU	^�����T�ZT�m�*a|	׫�:V���G�r+�/�T��@U�N׼�h�+	*�*sN1e�,e���nbJL<����"g=O��AL�WO!��߈Q���,ɉ'���lzJ���Q����t��9�F���A��g�B-����G�f|��x��5�'+��O��y��������F��2�����R�q�):VtI���/ʎ�UfěĲr'�g�g����5�t�ۛ�F���S�j1p�)�JD̻�ZR���Pq�r/jt�/sO�C�u����i�y�K�(Q��7őA�2���R�ͥ+lgzJ~��,eA��.���k�eQ�,l'Ɨ�2�,eaS��S�ԟe)��x��ood�d)����h��ZZ��`z�պ��;�Cr�rpi&��՜�Pf��+���:w��b�DUeZ��ڡ��iA>IN>���܋�b�O<�A���)�R�4��8+��k�Jpey��.���7ryc�!��M�a���v_��/�����'��t5`=��~	`�����p\�u����*>:|ٻ@�G�����wƝ�����K5�NZal������LH�]I'�^���+@q(�q2q+�g�}�o�����S߈:�R�݉C������?�1�.��
�ڈL�Fb%ħA ����Q���2�͍J]_�� A��Fb�����ݏ�4o��'2��F�  ڹ���W�L |����YK5�-�E�n�K�|�ɭvD=��p!V3gS��`�p|r�l	F�4�1{�V'&����|pj� ߫'ş�pdT�7`&�
�1g�����@D�˅ �x?)~83+	p �3W�w��j"�� '�J��CM�+ �Ĝ��"���4� ����nΟ	�0C���q'�&5.��z@�S1l5Z��]�~L�L"�"�VS��8w.����H�B|���K(�}
r%Vk$f�����8�ڹ���R�dϝx/@�_�k'�8���E���r��D���K�z3�^���Vw��ZEl%~�Vc���R� �Xk[�3��B��Ğ�Y��A`_��fa��D{������ @ ��dg�������Mƚ�R�`���s����>x=�����	`��s���H���/ū�R�U�g�r���/����n�;�SSup`�S��6��u���⟦;Z�AN3�|�oh�9f�Pg�����^��g�t����x��)Oq�Q�My55jF����t9����,�z�Z�����2��#�)���"�u���}'�*�>�����ǯ[����82һ�n���0�<v�ݑa}.+n��'����W:4TY�����P�ר���Cȫۿ�Ϗ��?����Ӣ�K�|y�@suyo�<�����{��x}~�����~�AN]�q�9ޝ�GG�����[�L}~�`�f%4�R!1�no���������v!�G����Qw��m���"F!9�vٿü�|j�����*��{Ew[Á��������u.+�<���awͮ�ӓ�Q �:�Vd�5*��p�ioaE��,�LjP��	a�/�˰!{g:���3`=`]�2��y`�"��N�N�p���� ��3�Z��䏔��9"�ʞ l�zP�G�ߙj��V�>���n�/��׷�G��[���\��T��Ͷh���ag?1��O��6{s{����!�1�Y�����91Qry��=����y=�ٮh;�����[�tDV5�chȃ��v�G ��T/'XX���~Q�7��+[�e��Ti@j��)��9��J�hJV�#�jk�A�1�^6���=<ԧg�B�*o�߯.��/�>W[M���I�o?V���s��|yu�xt��]�].��Yyx�w���`��C���pH��tu�w�J��#Ef�Y݆v�f5�e��8��=�٢�e��W��M9J�u�}]釧7k���:�o�����Ç����ս�r3W���7k���e�������ϛk��Ϳ�_��lu�۹�g�w��~�ߗ�/��ݩ�-�->�I�͒���A�	���ߥζ,�}�3�UbY?�Ӓ�7q�Db����>~8�]
� ^n׹�[�o���Z-�ǫ�N;U���E4=eȢ�vk��Z�Y�j���k�j1�/eȢK��J�9|�,UX65]W����lQ-�"`�C�.~8ek�{Xy���d��<��Gf�ō�E�Ӗ�T� �g��Y�*��.͊e��"�]�d������h��ڠ����c�qV�ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[             [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://djc36hgdnsoy2"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
                [remap]

path="res://.godot/exported/133200997/export-26e8a97d9ee22129de24c65c08ff6508-rounded_box.res"
        [remap]

path="res://.godot/exported/133200997/export-5e82850bd5753431b145711405557c1b-world.res"
              [remap]

path="res://.godot/exported/133200997/export-d1da9c91939224f652d8c3836bad4a25-particle.scn"
           [remap]

path="res://.godot/exported/133200997/export-e1f80c2eb4073548ce7c24a0a8e7fcb6-position_control_box.scn"
               [remap]

path="res://.godot/exported/133200997/export-0271e18ecf37a36b455ad0b215994549-world.scn"
              list=Array[Dictionary]([{
"base": &"Node2D",
"class": &"ElectricField",
"icon": "",
"language": &"GDScript",
"path": "res://Scenes/ElectricField.gd"
}, {
"base": &"RigidBody2D",
"class": &"Particle",
"icon": "",
"language": &"GDScript",
"path": "res://Scenes/particle.gd"
}, {
"base": &"HBoxContainer",
"class": &"PositionControlBox",
"icon": "",
"language": &"GDScript",
"path": "res://Scenes/PositionControlBox.gd"
}, {
"base": &"Node2D",
"class": &"Renderer",
"icon": "",
"language": &"GDScript",
"path": "res://Scenes/Renderer.gd"
}, {
"base": &"SpinBox",
"class": &"SpinBoxPosition",
"icon": "",
"language": &"GDScript",
"path": "res://Scenes/SpinBoxPosition.gd"
}])
<svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
          	   ��5t��    res://Resources/rounded_box.tres�i\ߕ?   res://Resources/world.tres��V��3�c   res://Scenes/particle.tscnTX�\&   res://Scenes/position_control_box.tscn�ݴ���2   res://Scenes/world.tscn'��)�шo   res://Sprites/negative.png��נ�3�   res://Sprites/particle_base.png���	�]�\   res://Sprites/positive.pngCu,�Q�3l   res://icon.svg              ECFG
      application/config/name$         electromagnetismsimulator      application/run/main_scene          res://Scenes/world.tscn    application/config/features$   "         4.2    Forward Plus       application/config/icon         res://icon.svg     autoload/GlobalVariables,      "   *res://Scripts/global_variables.gd  !   display/window/size/always_on_top            input/left_mouse�              deadzone      ?      events              InputEventMouseButton         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          button_mask           position              global_position               factor       �?   button_index         canceled          pressed           double_click          script      /   input_devices/pointing/emulate_touch_from_mouse         2   rendering/environment/defaults/default_clear_color                    �?   rendering/viewport/hdr_2d           