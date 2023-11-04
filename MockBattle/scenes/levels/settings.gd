extends Control

func _on_game_start_pressed():
	 get_tree().change_scene("res://scenes/levels/battle.tscn")

func _ready():
	var batch_settings = Settings.get_batch_setting()
	var command_settings = Settings.get_command_settings()
	
	$defensive_character/edit.text = batch_settings.get("defense", "")
	$attack_character/edit.text = batch_settings.get("attack", "")
	
	$defensive_command/edit.text = command_settings.get("defense", "")
	$attack_command/edit.text = command_settings.get("attack", "")
