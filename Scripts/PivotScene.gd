extends Node2D

signal energy_sent(energySent)
signal bullet_sent(position, rotation)
signal good_enought_energy


var particle
var energy = 100.0
var rotation_speed = 0.0
var isBreaking = false
export var acceleration_speed = 10.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	isBreaking = false
	if Input.is_action_pressed("ui_left"):
		ApplyImpulseLeft(delta)
	elif Input.is_action_pressed("ui_right"):
		ApplyImpulseRight(delta)
	else:
		RotationSpeedDump(delta)
	MaxRotationSpeedControl()
	ActivateCrusingParticle()
	EnergyCollector()
	ReachGoodEnoughtEnergy()

	$Pivot.rotation += rotation_speed / 100

func ApplyImpulseLeft(delta: float) -> void:
	var nextImpulse = 0
	if rotation_speed > 0:
		nextImpulse = 35 * delta
		isBreaking = true
	else:
		nextImpulse = GetNextImpulse(delta)
	rotation_speed -= nextImpulse	

func ApplyImpulseRight(delta: float) -> void:
	var nextImpulse = 0 
	if rotation_speed < 0:
		nextImpulse = 35 * delta
		isBreaking = true
	else:
		nextImpulse = GetNextImpulse(delta)
	rotation_speed += nextImpulse;

func GetNextImpulse(delta: float) -> float:
	if abs(rotation_speed) <= 5:
		return 10 * delta
	elif abs(rotation_speed) >= 20:
		return 30 * delta
	else:
		return (1 / abs(rotation_speed)) * 30 * delta

func RotationSpeedDump(delta: float) -> void:
	var dumpImpulse = 3 * delta;
	if rotation_speed > 0:
		rotation_speed -= dumpImpulse
	elif rotation_speed < 0:
		rotation_speed += dumpImpulse

func MaxRotationSpeedControl() -> void:
	if rotation_speed >= 40.1:
		rotation_speed = 40.1
	elif rotation_speed <= -40.1:
		rotation_speed = -40.1

func ActivateCrusingParticle() -> void:
	if abs(rotation_speed) >= 5:
		$Pivot/Sprite/Particles2DLast.emitting = true
	else:
		$Pivot/Sprite/Particles2DLast.emitting = false

	if abs(rotation_speed) >= 12:
		$Pivot/Sprite/Line2D.Activate(true)
	else:
		$Pivot/Sprite/Line2D.Activate(false)

func EnergyCollector() -> void:
	if abs(rotation_speed) > 6 && (Input.is_action_pressed("ui_left") || Input.is_action_pressed("ui_right")) && !isBreaking:
		var energySent = abs(rotation_speed) / 30
		energy -= energySent * (energy / 100)
		if energy < 4:
			energy = 4
		emit_signal("energy_sent", energy)
		$ChargeSound.pitch_scale += (100 - energy) / 500
		if !$ChargeSound.playing:
			$ChargeSound.play()
	else:
		var energySent = 2.0 / 70.0
		energy += energySent * (energy / 100)
		if energy > 100:
			energy = 100
		emit_signal("energy_sent", energy)
		if $ChargeSound.playing:
			$ChargeSound.pitch_scale = 1
			$ChargeSound.stop()

func spriteWantedToShot() -> void:
	if energy < 100:
		$Pivot/Sprite/AudioStreamPlayer.play()
		energy += 15 * (energy / 100)
		if energy > 100:
			energy = 100
		emit_signal("energy_sent", energy)
		emit_signal("bullet_sent", $Pivot/Sprite.global_transform.get_origin(), $Pivot/Sprite.global_transform.get_rotation())

func ReachGoodEnoughtEnergy() -> void:
	if energy < 30:
		emit_signal("good_enought_energy")

	
