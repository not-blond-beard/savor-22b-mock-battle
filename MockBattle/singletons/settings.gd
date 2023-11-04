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
	
func update_attack_batch_settings(setting: String):
	batch_settings.attack = setting

func update_defense_command_settings(setting: String):
	command_settings.defense = setting

func update_attack_command_settings(setting: String):
	command_settings.attack = setting


enum character_type {
	JJAJANG,
	JJAMBBONG,
	CAKE
}

var defense_character_position = [
	[
		{
			"type": character_type.JJAJANG,
			"id": 1
		}
	],
	[
		{
			"type": character_type.JJAMBBONG,
			"id": 2
		},
		{
			"type": character_type.JJAMBBONG,
			"id": 3
		},
	],
	[
		{
			"type": character_type.CAKE,
			"id": 4
		},
		{
			"type": character_type.JJAMBBONG,
			"id": 5
		},
	]
]

var attack_character_position = [
	[
		{
			"type": character_type.CAKE,
			"id": 6
		},
		{
			"type": character_type.JJAJANG,
			"id": 7
		},
		{
			"type": character_type.JJAJANG,
			"id": 8
		}
	],
	[
		{
			"type": character_type.JJAJANG,
			"id": 9
		}
	],
	[
		{
			"type": character_type.JJAMBBONG,
			"id": 10
		},
	]
]

# 지금은 임시로 프레임 계산이 모두중 끝나서 
# 순서대로 실행 한다는 느낌으로 테스트 
# 실제로는 is_attacker 이라는 게 없을 것?
var command_result_list = [
	{
		"id": 6,
		"skill_id": 1 
	},
	{
		"id": 4,
		"skill_id": 2
	},
	{
		"id": 7,
		"skill_id": 2
	},
	{
		"id": 2,
		"skill_id": 2
	},
	{
		"id": 8,
		"skill_id": 1
	},
]
