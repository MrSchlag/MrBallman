extends ColorRect

var gradient
var mat
var life = 100

func _ready() -> void:
	gradient = load("res://LifeGradient.tres")
	mat = $ColorRectEnergy.get_material()
	mat.set_shader_param("size", energy)


func _process(delta: float) -> void:

	

func LifeChange(pts: float):



