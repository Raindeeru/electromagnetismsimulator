extends RigidBody2D

#in microcoloumbs
@export var charge:float = 1 
@onready var base = $Base
@onready var positive = $Positive
@onready var negative = $Negative
const microcoloumb = 0.000001

# Called when the node enters the scene tree for the first time.
func _ready():
	if (charge > 0):
		positive.visible = true
		negative.visible = false
		base.self_modulate = Color.RED
	if (charge < 0):
		negative.visible = true
		positive.visible = false
		base.self_modulate = Color.BLUE
		
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
