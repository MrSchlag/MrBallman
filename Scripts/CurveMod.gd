extends KinematicBody2D

var speed = 16.0;
var aliveDelay = 0.0
var aliveTimer = 0.0
var value = 10
var rotationShift = PI/4

signal mob_hit(value)

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if aliveTimer < aliveDelay:
		aliveTimer += delta
		return
	
	var ca = cos(rotationShift);
	var sa = sin(rotationShift);
	var direction = Vector2(-global_transform.get_origin().x, -global_transform.get_origin().y).normalized()
	var linearVelocity = Vector2(direction.x * speed, direction.y * speed)
	linearVelocity = linearVelocity.rotated(rotationShift)

	move_and_slide(linearVelocity)

func Hit() -> void:
	emit_signal("mob_hit", value)
	hide()
	queue_free()

func ReachShield() -> void:
	hide()
	queue_free()
