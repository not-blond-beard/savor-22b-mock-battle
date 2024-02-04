extends Object

class_name SkillEffect

var skill_owner_id: int
var started_turn: int
var persistent_turn: int
var type: Settings.SkillEffectType
var skill_message: String

var meta
var target_stat


func _init(_skill_owner_id: int, _started_turn: int, _persistent_turn: int, _type: Settings.SkillEffectType, _meta = null, _target_stat = null, _skill_message = ""):
	skill_owner_id = _skill_owner_id
	started_turn = _started_turn
	persistent_turn = _persistent_turn
	type = _type
	target_stat = _target_stat
	meta = _meta
	skill_message = _skill_message
