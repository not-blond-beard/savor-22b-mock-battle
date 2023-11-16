extends "res://scenes/characters/player.gd"

func _ready():
	set_health(225)
	
	food_name = "짬뽕"
	
	defense = 30
	resistance = 40
	evasion = 0
	critical_chance = 0
	
	skill_1_settings = SkillSettings.new(10, -1)
	skill_2_settings = SkillSettings.new(15, 2)
	
func skill_1(team, enemies, turn):
	# 스킬 1 (발동 10)
	# 1열에 있는 음식 1개에게 데미지 30을 주고 손해프레임 3을 줍니다.

	var targets = get_foods_at_selected_area(1, enemies)
	var target = self.get_random_player(targets)
		
	target.take_damage(30)
	target.plus_damage_frame(3)
		

func skill_2(team, enemies, turn):
	# 스킬 2 (발동 15, 2턴 지속)
	# 모든 상대에게 5데미지를 주고 방어력을 10 깎습니다.
	
	for key in enemies:
		var enemy: InstanceMap = enemies[key]
		var effect = SkillEffect.new(
			self.get_id(),
			turn,
			skill_2_settings.persistent_turn,
			Settings.SkillEffectType.CHANGED_PLAYER_STATUS,
			-10,
			"defense"
		)
		
		enemy.instance_node.take_damage(5)
		enemy.instance_node.defense += -10
		enemy.instance_node.add_skill_effect(effect)
		
