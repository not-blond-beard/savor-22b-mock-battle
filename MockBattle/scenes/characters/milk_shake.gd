extends "res://scenes/characters/player.gd"

var is_skill_effect_enable: bool

func _ready():
	set_health(100)
	
	food_name = "밀크쉐이크"
	food_type = "단맛"
	
	_show_info()
	
	defense = 10
	resistance = 0
	evasion = 0
	critical_chance = 0
	
	skill_1_settings = SkillSettings.new("다음 시전되는 스킬 2의 공격력을 10 증가시킵니다.", 5, -1)
	skill_2_settings = SkillSettings.new("모든 상대에게 데미지 30을 줍니다.", 25, -1, 1)
	
	is_skill_effect_enable = false

func skill_1(team, enemies, turn, meta):
	# 스킬 1 (발동 5)
	# 다음 시전되는 스킬 2의 공격력을 10 증가시킵니다.
	
	super(team, enemies, turn, meta)
	
	is_skill_effect_enable = true
	
	self.add_buff_or_debuff(" 스킬 2 +10")
	
		
func skill_2(team, enemies, turn, meta):
	# 스킬 2 (발동 25, 중단)
	# 모든 상대에게 데미지 30을 줍니다.

	super(team, enemies, turn, meta)
	
	var damage: int = 30
	
	if is_skill_effect_enable:
		damage += 10
		is_skill_effect_enable = false
		remove_buff(" 스킬 2 +10")
	
	for key in enemies:
		var enemy: InstanceMap = enemies[key]
		
		enemy.instance_node.take_damage(damage, skill_2_settings.target_direction)
	
	play_all_target_skill_animation(Settings.ATTACK_TEAM_CODE)
