extends Sprite

signal sprite_wanted_to_shot

var shotDelay = 0.1
var shotTimer = 0.3

func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	shotTimer += delta
	if shotTimer > shotDelay && Input.is_action_pressed("ui_select"):
		emit_signal("sprite_wanted_to_shot")
		shotTimer = 0
	
