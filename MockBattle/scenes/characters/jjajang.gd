extends "res://scenes/characters/player.gd"


func _ready():
	set_health(100)
	
	defense = 50
	resistance = 10
	evasion = 0
	critical_chance = 0
	
	skill_1_settings = SkillSettings.new(7, 4)
	skill_2_settings = SkillSettings.new(10, 6)
	
func skill_1(team, enemies):
	# 스킬 1 (발동 7, 4턴 지속)
	# 본인의 방어력을 20 증가시킵니다.
	pass 
	
func skill_2(team, enemies):
	# 스킬 2 (발동 10, 6턴 지속)
	# 단일 공격에 대한 공격을 모두 대신 맞아줍니다 (수호)
	pass
