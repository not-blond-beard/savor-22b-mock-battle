extends "res://scenes/characters/player.gd"

func _ready():
	set_health(130)
	
	food_name = "마라탕"
	food_type = "매운맛"
	
	_show_info()
	
	defense = 20
	resistance = 0
	evasion = 0
	critical_chance = 0
	
	skill_1_settings = SkillSettings.new("1열에 있는 음식들에게 데미지 5와 기절 상태이상을 부여합니다.", 14, 2)
	skill_2_settings = SkillSettings.new("1열에 있는 음식들에게 데미지 60을 줍니다.", 20, -1, 1)

func skill_1(team, enemies, turn, meta):
	# 스킬 1 (발동 14, 2턴 지속)
	# 1열에 있는 음식들에게 데미지 5와 기절 상태이상을 부여합니다.
	super(team, enemies, turn, meta)

	var targets = get_foods_at_selected_area(0, enemies)
	
	for enemy in targets:
		enemy.take_damage(calculate_inflicted_damage(5), skill_1_settings.target_direction)
		enemy.toggle_stun(true)

func skill_2(team, enemies, turn, meta):
	# 스킬 2 (발동 20, 중단)
	# 1열에 있는 음식들에게 데미지 60을 줍니다.

	super(team, enemies, turn, meta)

	var targets = get_foods_at_selected_area(0, enemies)

	for enemy in targets:
		enemy.take_damage(calculate_inflicted_damage(60), skill_2_settings.target_direction)
