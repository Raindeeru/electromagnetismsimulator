extends MarginContainer

@export var renderer:Renderer

@onready var charge_slider = $"Panel/VBoxContainer/Charge/ChargeLabel/Chargeslider/HSlider"
@onready var charge_value = $"Panel/VBoxContainer/Charge/ChargeLabel/ChargeValue"
@onready var charge_multiplier_select = $Panel/VBoxContainer/Charge/ChargeLabel/ChargeMultiplier

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
		charge_slider.value = GlobalVariables.selected_particle.charge/GlobalVariables.selected_particle.charge_multiplier


func _on_h_slider_value_changed(value):
	charge_value.value = value
	if value >= -1 && value <= 1:
		GlobalVariables.selected_particle.change_charge(value, GlobalVariables.selected_particle.charge_multiplier)

func _on_charge_value_value_changed(value):
	charge_slider.value = value
	GlobalVariables.selected_particle.change_charge(value, GlobalVariables.selected_particle.charge_multiplier)

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

func _on_charge_multiplier_visibility_changed():
	if GlobalVariables.selected_particle != null:
		charge_multiplier_select.select(convert_prefix_to_index(GlobalVariables.selected_particle.charge_multiplier))

func _on_charge_multiplier_item_selected(index):
	if GlobalVariables.selected_particle != null:
		GlobalVariables.selected_particle.change_charge(GlobalVariables.selected_particle.base_charge, convert_index_to_prefix(index))
		renderer.queue_redraw()

func convert_index_to_prefix(val:int):
	match val:
		0:
			return Prefix.BASE
		1:
			return Prefix.CENTI
		2:
			return Prefix.MILLI
		3:
			return Prefix.MICRO
		4:
			return Prefix.NANO

func convert_prefix_to_index(val:float):
	match val:
		Prefix.BASE:
			return 0
		Prefix.CENTI:
			return 1
		Prefix.MILLI:
			return 2
		Prefix.MICRO:
			return 3
		Prefix.NANO:
			return 4
