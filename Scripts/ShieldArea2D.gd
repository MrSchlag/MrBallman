extends Area2D

export var gradient : Gradient

signal life_decreased(lifeLost)

func _ready() -> void:
	connect("body_entered", self, "BodyEntered")
	pass 

func _process(delta: float) -> void:
	pass

func BodyEntered(body):
	if body.has_method("ReachShield"):
		body.ReachShield()
		emit_signal("life_decreased", 10)
