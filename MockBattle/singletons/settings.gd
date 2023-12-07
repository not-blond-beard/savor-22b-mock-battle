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

func _ready():
	pass


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

var defense_position = []
var defense_command = []

var attack_position = []
var attack_command = []
