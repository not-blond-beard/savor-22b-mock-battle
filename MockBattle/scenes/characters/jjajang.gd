extends "res://scenes/characters/player.gd"


func _ready():
	set_health(100)
	
	food_name = "짜장"
	food_type = "짠맛"
	
	defense = 50
	resistance = 10
	evasion = 0
	critical_chance = 0
	
	_show_info()
	
	skill_1_settings = SkillSettings.new("본인의 방어력을 20 증가시킵니다.", 7, 4)
	skill_2_settings = SkillSettings.new("단일 공격에 대한 공격을 모두 대신 맞아줍니다", 10, 6)
	
func skill_1(team, enemies, turn, meta):
	# 스킬 1 (발동 7, 4턴 지속)
	# 본인의 방어력을 20 증가시킵니다.
	super(team, enemies, turn, meta)
		
	var effect = SkillEffect.new(
		self.get_id(),
		turn,
		skill_1_settings.persistent_turn,
		Settings.SkillEffectType.CHANGED_PLAYER_STATUS,
		20,
		"defense",
		" 방어력 +20"
	)
	self.defense += 20
	self.add_skill_effect(
		effect
	)

		
	
func skill_2(team, enemies, turn, meta):
	# 스킬 2 (발동 10, 6턴 지속)
	# 단일 공격에 대한 공격을 모두 대신 맞아줍니다 (수호)
	super(team, enemies, turn, meta)
	
	var efffect = SkillEffect.new(
		self.get_id(),
		turn,
		skill_2_settings.persistent_turn,
		Settings.SkillEffectType.PROTECT
	)
	
	for key in team:
		var food: Player = team[key].instance_node
		
		food.add_skill_effect(efffect)
