extends Control

@onready var d1 = $defensive_character/edit
@onready var a1 = $attack_character/edit
@onready var d2 = $defensive_command/edit
@onready var a2 = $attack_command/edit

func _on_game_start_pressed():
	GameData.defense_position_str = d1.text
	GameData.defense_command_str = d2.text
	GameData.attack_position_str = a1.text
	GameData.attack_command_str = a2.text
	
	GameData.saveall()
	
	get_tree().change_scene_to_file("res://scenes/levels/battle.tscn")

func al_ready():
	var batch_settings = Settings.get_batch_setting()
	var command_settings = Settings.get_command_settings()
	
	$defensive_character/edit.text = batch_settings.get("defense", "")
	$attack_character/edit.text = batch_settings.get("attack", "")
	
	$defensive_command/edit.text = command_settings.get("defense", "")
	$attack_command/edit.text = command_settings.get("attack", "")


func _ready():
	d1.text = GameData.defense_position_str
	d2.text = GameData.defense_command_str	
	a1.text = GameData.attack_position_str
	a2.text = GameData.attack_command_str
