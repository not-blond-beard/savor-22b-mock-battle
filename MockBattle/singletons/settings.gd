extends Node


var batch_settings = {
	"defense": "",
	"attack": "",
}

var command_settings = {
	"defense": "",
	"attack": ""
}

func get_batch_setting() -> Dictionary:
	return batch_settings
	
func get_command_settings() -> Dictionary:
	return command_settings
	
func update_defense_batch_settings(setting: String):
	batch_settings.defense = setting
	print("defense_batch_setting: ")
	print(setting)
	

func update_attack_batch_settings(setting: String):
	batch_settings.attack = setting
	print("attack_batch_setting: ")
	print(setting)

func update_defense_command_settings(setting: String):
	batch_settings.defense = setting
	print("defense_command_setting: ")
	print(setting)

func update_attack_command_settings(setting: String):
	batch_settings.attack = setting
	print("attack_command_setting: ")
	print(setting)
