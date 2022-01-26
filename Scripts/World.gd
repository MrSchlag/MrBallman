extends Node2D

var bulletScene

func _ready() -> void:
	bulletScene = load("res://Scenes/Bullet.tscn")
	$PivotScene.connect("energy_sent", self, "recieve_energy")
	$PivotScene.connect("bullet_sent", self, "create_bullet")
	$PivotScene.connect("good_enought_energy", $TutorialNode, "EnergyUnderstood")
	$PivotScene/Pivot/Sprite.connect("sprite_wanted_to_shot", $TutorialNode, "ShootGoodEnought")
	$PivotScene/Pivot/Sprite.connect("sprite_wanted_to_shot", $PivotScene, "spriteWantedToShot")
	$TutorialNode.connect("start_waves", $MobSpawner, "WavesStarts")
	$PivotScene/ShieldArea2D.connect("life_decreased", $ColorRectRail, "LifeChange")
	$ColorRectRail.connect("player_died", self, "EndGame")
	$MobSpawner.connect("text_wave", $TutorialNode, "TextWave")
	$MobSpawner.connect("end_wave", self, "Win")


func _process(delta: float) -> void:
	if Input.is_action_pressed("restart"):
		get_tree().change_scene("res://Scenes/World.tscn")

func recieve_energy(energy : float) -> void:
	var mat = $ColorRectEnergy.get_material()
	mat.set_shader_param("size", energy)

func create_bullet(position : Vector2, rotation : float) -> void:
	var bullet = bulletScene.instance()
	bullet.position = position
	bullet.SetDirectionVec(rotation)
	bullet.soundStream = $AudioStreamPlayer2
	$BulletSpawn.add_child(bullet)

func EndGame():
	$TutorialNode.TextWave("Game Over - R to restart\nThanks for playing")
	$PivotScene.queue_free()
	$MobSpawner.hasStart = false

func Win():
	print("endGame")
	$TutorialNode.TextWave("You won !! - R to restart\nThanks for playing")

