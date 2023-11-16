extends "res://scenes/characters/player.gd"

func _ready():
	set_health(100)
	
	food_name = "두릅무침"
	
	defense = 50
	resistance = 10
	evasion = 0
	critical_chance = 0
	
	skill_1_settings = SkillSettings.new(20, -1)
	skill_2_settings = SkillSettings.new(12, -1)
	
func skill_1(team, enemies, turn):
	# 스킬 1 (발동 20)
	# 상대 2열과 3열에 있는 음식들에게 기절 상태이상을 부여합니다.
	
	var targets: Array[Player] = []
	targets.append(self.get_foods_at_selected_area(1, enemies))
	targets.append(self.get_foods_at_selected_area(2, enemies))
	
	for target in targets:
		target.toggle_stun(true)
	
func skill_2(team, enemies, turn):
	# 스킬 2 (발동 12)
	# 상대 1열에 있는 음식들에게 기절 상태이상을 부여합니다.
	var targets: Array[Player] = self.get_foods_at_selected_area(0, enemies)
	
	for target in targets:
		target.toggle_stun(true)
