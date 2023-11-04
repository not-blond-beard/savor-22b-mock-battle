extends "res://scenes/characters/player.gd"


func _ready():
	set_health(100)
	
	defense = 50
	resistance = 10
	evasion = 0
	critical_chance = 0
	
	
func skill_1(instance_map):
	# 스킬 1 (발동 7, 4턴 지속)
	# 본인의 방어력을 20 증가시킵니다.
	pass 
	
func skill_2(instance_map):
	# 스킬 2 (발동 10, 6턴 지속)
	# 단일 공격에 대한 공격을 모두 대신 맞아줍니다 (수호)
	pass
