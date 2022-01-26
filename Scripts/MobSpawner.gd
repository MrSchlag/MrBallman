extends Node2D

class SpawnPack:
	var type : String
	var position : Vector2
	var delay : float
	var speed : float
	var rotationShift : float

	func _init(typeArg : String, positionArg : Vector2, delayArg : float, speedArg : float, rotationShiftArg : float):
		type = typeArg
		position = positionArg
		delay = delayArg
		speed = speedArg
		rotationShift = rotationShiftArg

class WavePack:
	var wave : Array
	var duration : float
	var name : String

	func _init(durationArg : float, nameArg : String):
		duration = durationArg
		name = nameArg


var waves : Array

var waveDelay = 2
var waveTimer = 2
var waveCounter = 0

var baseMob
var curveMob
var hasStart = false

func _ready() -> void:
	baseMob = load("res://Scenes/BaseMob.tscn")
	curveMob = load("res://Scenes/CurveMob.tscn")

	waves.append(CreateTutorialWave())
	waves.append(CreateWaveBase(10, "2/6 - easy"))
	waves.append(CreateWaveCurve(30, "3/6 - Curve"))
	waves.append(CreateWaveBase(15, "4/6 - ..."))
	waves.append(CreateWaveCurve(25, "5/6 - almost done"))
	waves.append(CreateWaveLast())
	waves.append(WavePack.new(1, "end"))

func _process(delta: float) -> void:
	if hasStart == false:
		return
	waveTimer += delta
	if waveTimer > waveDelay && waveCounter < waves.size():
		print("launch wave " + str(waveCounter))
		WaveSpawn(waves[waveCounter])
		waveCounter += 1
		waveTimer = 0

func CreateTutorialWave() -> WavePack:
	var wavePack = WavePack.new(23, "1/6 - tutorial")
	var wave = wavePack.wave;

	wave.append(SpawnPack.new("basic", Vector2(210, -50), 0, 7, 0))
	wave.append(SpawnPack.new("basic", Vector2(210, -25), 3, 7, 0))
	wave.append(SpawnPack.new("basic", Vector2(210, 0), 6, 7, 0))
	wave.append(SpawnPack.new("basic", Vector2(210, 25), 9, 7, 0))
	wave.append(SpawnPack.new("basic", Vector2(210, 50), 12, 7, 0))

	return wavePack

func CreateWaveBase(speed : float, name : String) -> WavePack:
	var wavePack = WavePack.new(43, name)
	var wave = wavePack.wave;

	wave.append(SpawnPack.new("basic", Vector2(170, 115), 0, speed, 0))
	wave.append(SpawnPack.new("basic", Vector2(160, 150), 1, speed, 0))
	wave.append(SpawnPack.new("basic", Vector2(170, 170), 3, speed, 0))
	wave.append(SpawnPack.new("basic", Vector2(180, 100), 4, speed, 0))
	wave.append(SpawnPack.new("basic", Vector2(190, 100), 4, speed, 0))
	wave.append(SpawnPack.new("basic", Vector2(200, 50), 8, speed, 0))
	wave.append(SpawnPack.new("basic", Vector2(200, -50), 10, speed, 0))
	wave.append(SpawnPack.new("basic", Vector2(180, -100), 10, speed, 0))

	wave.append(SpawnPack.new("basic", Vector2(-170, -115), 15, speed, 0))
	wave.append(SpawnPack.new("basic", Vector2(-160, -150), 15, speed, 0))
	wave.append(SpawnPack.new("basic", Vector2(-170, -170), 15, speed, 0))
	wave.append(SpawnPack.new("basic", Vector2(-180, -100), 15, speed, 0))
	wave.append(SpawnPack.new("basic", Vector2(-190, -100), 20, speed, 0))
	wave.append(SpawnPack.new("basic", Vector2(-200, -50), 20, speed, 0))
	wave.append(SpawnPack.new("basic", Vector2(-200, 50), 20, speed, 0))
	wave.append(SpawnPack.new("basic", Vector2(-180, 100), 20, speed, 0))

	wave.append(SpawnPack.new("basic", Vector2(-170, 115), 26, speed, 0))
	wave.append(SpawnPack.new("basic", Vector2(-160, 150), 26, speed, 0))
	wave.append(SpawnPack.new("basic", Vector2(-170, 170), 26, speed, 0))
	wave.append(SpawnPack.new("basic", Vector2(170, -115), 30, speed, 0))
	wave.append(SpawnPack.new("basic", Vector2(160, -150), 30, speed, 0))
	wave.append(SpawnPack.new("basic", Vector2(170, -170), 30, speed, 0))
	
	return wavePack

func CreateWaveCurve(speed : float, name : String) -> WavePack:
	var wavePack = WavePack.new(24, name)
	var wave = wavePack.wave;
	
	wave.append(SpawnPack.new("curve", Vector2(210, -50), 3, speed + 4, PI/3))
	wave.append(SpawnPack.new("curve", Vector2(210, -25), 2, speed + 2, PI/4))
	wave.append(SpawnPack.new("curve", Vector2(210, 0), 0, speed, 0))
	wave.append(SpawnPack.new("curve", Vector2(210, 25), 2, speed + 2, -PI/4))
	wave.append(SpawnPack.new("curve", Vector2(210, 50), 3, speed + 4, -PI/3))

	wave.append(SpawnPack.new("curve", Vector2(-210, -50), 13, speed + 4, -PI/3))
	wave.append(SpawnPack.new("curve", Vector2(-210, -25), 12, speed + 2, -PI/4))
	wave.append(SpawnPack.new("curve", Vector2(-210, 0), 10, speed, 0))
	wave.append(SpawnPack.new("curve", Vector2(-210, 25), 12, speed + 2, PI/4))
	wave.append(SpawnPack.new("curve", Vector2(-210, 50), 13, speed + 4, PI/3))

	return wavePack

func CreateWaveLast() -> WavePack:
	var wavePack = WavePack.new(31, "6/6 - Last")
	var wave = wavePack.wave;
	var speed = 13

	wave.append(SpawnPack.new("basic", Vector2(170, 115), 0, speed, 0))
	wave.append(SpawnPack.new("basic", Vector2(160, 150), 1, speed, 0))
	wave.append(SpawnPack.new("basic", Vector2(170, 170), 3, speed, 0))
	wave.append(SpawnPack.new("basic", Vector2(180, 100), 4, speed, 0))
	wave.append(SpawnPack.new("basic", Vector2(-190, -100), 12, speed, 0))
	wave.append(SpawnPack.new("basic", Vector2(-200, -50), 12, speed, 0))
	wave.append(SpawnPack.new("basic", Vector2(-200, 50), 13, speed, 0))
	wave.append(SpawnPack.new("basic", Vector2(-180, 100), 14, speed, 0))

	wave.append(SpawnPack.new("curve", Vector2(210, -50), 3, speed + 14, PI/3))
	wave.append(SpawnPack.new("curve", Vector2(210, -25), 2, speed + 12, PI/4))
	wave.append(SpawnPack.new("curve", Vector2(210, 0), 0, speed, 10))
	wave.append(SpawnPack.new("curve", Vector2(210, 25), 2, speed + 12, -PI/4))
	wave.append(SpawnPack.new("curve", Vector2(210, 50), 3, speed + 14, -PI/3))

	wave.append(SpawnPack.new("curve", Vector2(-210, -50), 16, speed + 14, PI/3))
	wave.append(SpawnPack.new("curve", Vector2(-210, -25), 15, speed + 12, PI/4))
	wave.append(SpawnPack.new("curve", Vector2(-210, 0), 14, speed, 14))
	wave.append(SpawnPack.new("curve", Vector2(-210, 25), 15, speed + 12, -PI/4))
	wave.append(SpawnPack.new("curve", Vector2(-210, 50), 16, speed + 14, -PI/3))

	return wavePack

signal end_wave
signal text_wave(name)

func WaveSpawn(wavePack : WavePack) -> void:
	emit_signal("text_wave", wavePack.name)
	if wavePack.name == "end":
		emit_signal("end_wave")
		return
	for spawnPack in wavePack.wave:
		var mob
		if spawnPack.type == "basic":
			mob = baseMob.instance()
		elif spawnPack.type == "curve":
			mob = curveMob.instance()
			mob.rotationShift = spawnPack.rotationShift
		mob.position = spawnPack.position
		mob.aliveDelay = spawnPack.delay
		mob.speed = spawnPack.speed
		waveDelay = wavePack.duration
		add_child(mob)

func WavesStarts() -> void:
	hasStart = true

