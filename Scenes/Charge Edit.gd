extends MarginContainer

@onready var charge_slider = $"Panel/VBoxContainer/Charge/ChargeLabel/Chargeslider/HSlider"
@onready var charge_value = $"Panel/VBoxContainer/Charge/ChargeLabel/ChargeValue"

@onready var x_position = $"Panel/VBoxContainer/Position/HBoxContainer/XBox/SpinBoxX"
@onready var y_position = $"Panel/VBoxContainer/Position/HBoxContainer/YBox/SpinBoxY"

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
		x_position.value = GlobalVariables.selected_particle.position.x

func _on_spin_box_y_visibility_changed():
	if GlobalVariables.selected_particle != null:
		y_position.value = GlobalVariables.selected_particle.position.y


func _on_spin_box_x_value_changed(value):
	GlobalVariables.selected_particle.position.x = value
	GlobalVariables.selected_particle.edited.emit()

func _on_spin_box_y_value_changed(value):
	GlobalVariables.selected_particle.position.y = value
	GlobalVariables.selected_particle.edited.emit()

