extends "res://scenes/characters/player.gd"

func _ready():
	set_health(50)
	
	food_name = "홍삼즙"
	
	defense = 0
	resistance = 0
	evasion = 50
	critical_chance = 0
	
	skill_1_settings = SkillSettings.new(12, 6)
	skill_2_settings = SkillSettings.new(10, 4)
	
func skill_1(team, enemies, turn, meta):
	# 스킬 1 (발동 12, 6턴 지속)
	# 본인의 회피력을 30 증가시킵니다.
	var effect = SkillEffect.new(
		self.get_id(),
		turn,
		skill_1_settings.persistent_turn,
		Settings.SkillEffectType.CHANGED_PLAYER_STATUS,
		30,
		"evasion"
	)
	self.evasion += 30
	self.add_skill_effect(
		effect
	)
	
func skill_2(team, enemies, turn, meta):
	# 스킬 2 (발동 10, 4턴 지속)
	# 단일 공격에 대한 공격을 모두 대신 맞아줍니다 (수호)
	var effect = SkillEffect.new(
		self.get_id(),
		turn,
		skill_2_settings.persistent_turn,
		Settings.SkillEffectType.PROTECT
	)
	
	for key in team:
		var food: Player = team[key].instance_node
		food.add_skill_effect(effect)
