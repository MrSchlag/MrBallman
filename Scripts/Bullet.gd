extends KinematicBody2D

var directionVec;

var soundStream : AudioStreamPlayer
var particle

func _ready() -> void:
	particle = load("res://Scenes/ParticleExplosion.tscn")

func _process(delta: float) -> void:
	pass

func _physics_process(delta):
	var linearVelocity = Vector2(directionVec.x * 300 * delta, directionVec.y * 300 * delta)
	var collision = move_and_collide(linearVelocity)
	if collision && collision.collider.has_method("Hit"):
		var particleInst = particle.instance()
		particleInst.position = global_transform.get_origin()
		get_parent().add_child(particleInst)
		particleInst.get_child(0).emitting = true
		collision.collider.Hit()
		soundStream.play()
		hide()
		queue_free()

func SetDirectionVec(rotation : float):
	var piDiv2 = PI/2
	directionVec = Vector2(cos(rotation - piDiv2), sin(rotation - piDiv2))
	directionVec = directionVec.normalized()
