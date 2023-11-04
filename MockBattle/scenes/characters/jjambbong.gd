extends "res://scenes/characters/player.gd"

func _ready():
	set_health(225)
	
	defense = 30
	resistance = 40
	evasion = 0
	critical_chance = 0
	
	
func skill_1(instance_map):
	# 스킬 1 (발동 10)
	# 1열에 있는 음식 1개에게 데미지 30을 주고 손해프레임 3을 줍니다.
	pass
	
func skill_2(instance_map):
	# 스킬 2 (발동 15, 2턴 지속)
	# 모든 상대에게 5데미지를 주고 방어력을 10 깎습니다.
	pass
