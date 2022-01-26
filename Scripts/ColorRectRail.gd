extends ColorRect

var gradient
var mat
var life = 100
var lifeMax = 100

signal player_died

func _ready() -> void:
	gradient = load("res://LifeGradient.tres")
	mat = get_material()
	LifeChange(0)


func _process(delta: float) -> void:
	pass
	

func LifeChange(pts: float):
	life -= pts
	var color = gradient.interpolate(life / lifeMax)
	mat.set_shader_param("color", color)
	if life <= 0:
		emit_signal("player_died")



