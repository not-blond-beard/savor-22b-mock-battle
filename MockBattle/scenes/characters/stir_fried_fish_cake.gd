extends "res://scenes/characters/player.gd"


func _ready():
	set_health(100)
	
	food_name = "어묵볶음"
	food_type = "짠맛"
	
	_show_info()
	
	defense = 0
	resistance = 20
	evasion = 0
	critical_chance = 0
	
	skill_1_settings = SkillSettings.new("체력이 가장 낮은 음식 체력을 30 회복시킵니다.", 10, -1)
	skill_2_settings = SkillSettings.new("모든 아군 음식의 체력을 10 회복시킵니다.", 15, -1)
	
func skill_1(team, enemies, turn, meta):
	# 스킬 1 (발동 10)
	# 체력이 가장 낮은 음식 체력을 30 회복시킵니다.
	
	super(team, enemies, turn, meta)
	
	var target: Player = get_most_unheath_food(team)

	target.add_health(30)
	
		
func skill_2(team, enemies, turn, meta):
	# 스킬 2 (발동 15)
	# 모든 아군 음식의 체력을 10 회복시킵니다.

	super(team, enemies, turn, meta)
	
	for key in team:
		var target: InstanceMap = team[key]
		
		target.instance_node.add_health(10)
	
