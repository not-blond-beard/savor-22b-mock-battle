extends "res://scenes/characters/player.gd"

func _ready():
	set_health(80)
	
	food_name = "마라샹궈"
	food_type = "짠맛"
	
	_show_info()
	
	defense = 10
	resistance = 40
	evasion = 30
	critical_chance = 40
	
	skill_1_settings = SkillSettings.new("체력이 가장 낮은 음식 하나에게 데미지 10과 방어력 감소 10을 부여합니다.", 10, 3)
	skill_2_settings = SkillSettings.new("체력이 가장 낮은 음식 하나에게 데미지 50 줍니다.", 18, -1, 1)
	

func skill_1(team, enemies, turn, meta):
	# 스킬 1 (발동 10, 3턴 지속)
	# 체력이 가장 낮은 음식 하나에게 데미지 10과 방어력 감소 10을 부여합니다.
	
	super(team, enemies, turn, meta)
	
	var effect = SkillEffect.new(
		self.get_id(),
		turn,
		skill_1_settings.persistent_turn,
		Settings.SkillEffectType.CHANGED_PLAYER_STATUS,
		-10,
		"defense",
		" 방어력 -10"
	)
	
	var target = get_most_unheath_food(enemies)
	var result_target: Player = target.get_matching_character_to_tanking(enemies)
	
	if result_target:
		result_target.take_damage(calculate_inflicted_damage(35, result_target), skill_1_settings.target_direction)
		result_target.defense += -10
		result_target.add_skill_effect(effect)
		play_single_skill_animation(result_target)
		
		
func skill_2(team, enemies, turn, meta):
	# 스킬 2 (발동 18, 중단)
	# 체력이 가장 낮은 음식 하나에게 데미지 50 줍니다.
	super(team, enemies, turn, meta)
	
	var target = get_most_unheath_food(enemies)
	var result_target: Player = target.get_matching_character_to_tanking(enemies)
	
	if result_target:
		result_target.take_damage(calculate_inflicted_damage(50, result_target), skill_2_settings.target_direction)
		play_single_skill_animation(result_target)
