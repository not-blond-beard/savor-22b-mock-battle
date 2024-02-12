extends "res://scenes/characters/player.gd"



func _ready():
	set_health(100)
	
	food_name = "케이크"
	food_type = "단맛"
	
	defense = 40
	resistance = 10
	evasion = 0
	critical_chance = 0
	
	_show_info()
	
	skill_1_settings = SkillSettings.new("체력이 가장 낮은 상대에게 데미지 45를 줍니다", 13, 1)
	skill_2_settings = SkillSettings.new("1열에 있는 음식들에게 데미지 25를 줍니다.", 18, 1, )
	
		
func skill_1(team, enemies, turn, meta):
	# 스킬 1 (발동 13)
	# 체력이 가장 낮은 상대에게 
	# 데미지 35를 줍니다.
	super(team, enemies, turn, meta)
	
	var target = get_most_unheath_food(enemies)
	
	var result_target: Player = target.get_matching_character_to_tanking(enemies)
	
	if result_target:
		result_target.take_damage(calculate_inflicted_damage(45, result_target), skill_1_settings.target_direction)
		play_single_skill_animation(result_target)
	
	
	
func skill_2(team, enemies, turn, meta):
	# 스킬 2 (발동 18)
	# 1열에 있는 음식들에게 데미지 15를 줍니다.
	
	super(team, enemies, turn, meta)

	var targets = get_foods_at_selected_area(0, enemies)
	
	for enemy in targets:
		enemy.take_damage(calculate_inflicted_damage(25, enemy), skill_2_settings.target_direction)
		play_single_skill_animation(enemy)
