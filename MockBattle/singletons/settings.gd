extends Node2D


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
	CAKE,
	RED_GINSENG_JUICE,
	SEASONED_BELLFLOWER_ROOT,
	MALA_XIANG_GUO,
	MILK_SHAKE,
	MALA_TANG,
	KUNG_PAO_CHICKEN,
	STIR_FRIED_FISH_CAKE
}

enum SkillEffectType {
	PROTECT,
	STUNNED,
	CHANGED_PLAYER_STATUS
}

const DEFENSE_TEAM_CODE: int = 1
const ATTACK_TEAM_CODE: int = 2

var defense_position = [
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

var defense_command = [
	{
		"id": 1,
		"skill_id": 1
	},
	{
		"id": 1,
		"skill_id": 2
	},
	{
		"id": 1,
		"skill_id": 0,
		"meta": 1,
	},
	{
		"id": 2,
		"skill_id": 1
	},
	{
		"id": 2,
		"skill_id": 2
	},
	{
		"id": 1,
		"skill_id": 0,
		"meta": 0,
	},
	{
		"id": 3,
		"skill_id": 1
	},
	{
		"id": 3,
		"skill_id": 2
	},
	{
		"id": 1,
		"skill_id": 0,
		"meta": 1,
	},
	{
		"id": 4,
		"skill_id": 1
	},
	{
		"id": 4,
		"skill_id": 2
	},
	{
		"id": 5,
		"skill_id": 1
	},
	{
		"id": 5,
		"skill_id": 2
	},
]

var attack_position = [
	[
		{
			"type": character_type.CAKE,
			"id": 6
		},
		{
			"type": character_type.MILK_SHAKE,
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

var attack_command = [
	{
		"id": 6,
		"skill_id": 1
	},
	{
		"id": 6,
		"skill_id": 2
	},
	{
		"id": 7,
		"skill_id": 1
	},
	{
		"id": 7,
		"skill_id": 2
	},
	{
		"id": 8,
		"skill_id": 1
	},
	{
		"id": 8,
		"skill_id": 2
	},
	{
		"id": 9,
		"skill_id": 1
	},
	{
		"id": 9,
		"skill_id": 2
	},
	{
		"id": 10,
		"skill_id": 1
	},
	{
		"id": 10,
		"skill_id": 2
	}
]

