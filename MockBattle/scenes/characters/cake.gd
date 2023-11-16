extends "res://scenes/characters/player.gd"



func _ready():
	set_health(180)
	
	food_name = "케이크"
	
	defense = 40
	resistance = 10
	evasion = 0
	critical_chance = 0
	
	skill_1_settings = SkillSettings.new(13, 1)
	skill_2_settings = SkillSettings.new(18, 1)
	
		
func skill_1(team, enemies, turn):
	# 스킬 1 (발동 13)
	# 체력이 가장 낮은 상대에게 
	# 데미지 35를 줍니다.
	
	var target = get_most_unheath_food(enemies)
	var result_target: Player = target.get_matching_character_to_tanking(enemies)
	
	if result_target:
		result_target.take_damage(35)
	
func skill_2(team, enemies, turn):
	# 스킬 2 (발동 18)
	# 1열에 있는 음식들에게 데미지 15를 줍니다.
	
	var targets = get_foods_at_selected_area(0, enemies)
	
	for enemy in targets:
		enemy.take_damage(15)
