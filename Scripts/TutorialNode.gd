extends Node2D

var shootCounter = 0
var enjoyDuration = 3.0
var enjoyTimer = 0.0

var waveNameDuration = 5.0
var waveNameTimer = 0.0

var energyUnderstood = false
var shootUnderstood = false

signal start_waves

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	waveNameTimer += delta
	if waveNameTimer > waveNameDuration:
		$WaveName.visible = false
	if shootUnderstood:
		enjoyTimer += delta
		if enjoyTimer > enjoyDuration:
			$Enjoy.visible = false

func EnergyUnderstood() -> void:
	if energyUnderstood || shootUnderstood:
		return
	$LeftArrowKey.visible = false
	$RightArrowKey.visible = false
	$Turn.visible = false
	$SpaceKey.visible = true
	$Shoot.visible = true
	energyUnderstood = true
	emit_signal("start_waves")

func ShootGoodEnought() -> void:
	if shootUnderstood:
		return
	shootCounter += 1
	if shootCounter > 4:
		$SpaceKey.visible = false
		$Shoot.visible = false
		$Enjoy.visible = true
		shootUnderstood = true

func TextWave(name : String) -> void:
	$WaveName.text = name
	$WaveName.visible = true
	waveNameTimer = 0
