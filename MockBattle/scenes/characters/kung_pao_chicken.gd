extends "res://scenes/characters/player.gd"

func _ready():
	set_health(80)
	
	food_name = "꿔바로우"
	food_type = "신맛"
	
	_show_info()
	
	defense = 30
	resistance = 20
	evasion = 0
	critical_chance = 20
	
	skill_1_settings = SkillSettings.new("모든 상대에게 데미지 20을 줍니다.", 15, -1)
	skill_2_settings = SkillSettings.new("모든 상대에게 데미지 10을 줍니다.", 15, -1, 1)

func skill_1(team, enemies, turn, meta):
	# 스킬 1 (발동 15)
	# 모든 상대에게 데미지 20을 줍니다.
	super(team, enemies, turn, meta)

	for key in enemies:
		var enemy: InstanceMap = enemies[key]
		
		enemy.instance_node.take_damage(20, skill_1_settings.target_direction)

func skill_2(team, enemies, turn, meta):
	# 스킬 2 (발동 15, 중단)
	# 모든 상대에게 데미지 10을 줍니다.

	super(team, enemies, turn, meta)
	
	for key in enemies:
		var enemy: InstanceMap = enemies[key]
		
		enemy.instance_node.take_damage(10, skill_2_settings.target_direction)
