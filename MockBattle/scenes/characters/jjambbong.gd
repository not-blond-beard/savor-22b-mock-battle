extends "res://scenes/characters/player.gd"

func _ready():
	set_health(225)
	
	food_name = "짬뽕"
	food_type = "매운맛"
	
	defense = 30
	resistance = 40
	evasion = 0
	critical_chance = 0
	
	_show_info()
	
	skill_1_settings = SkillSettings.new("1열에 있는 음식 1개에게 데미지 30을 주고 손해프레임 3을 줍니다", 10, -1)
	skill_2_settings = SkillSettings.new("모든 상대에게 5데미지를 주고 방어력을 10 깎습니다.", 15, 2)
	
func skill_1(team, enemies, turn, meta):
	# 스킬 1 (발동 10)
	# 1열에 있는 음식 1개에게 데미지 30을 주고 손해프레임 3을 줍니다.
	super(team, enemies, turn, meta)

	var targets = get_foods_at_selected_area(0, enemies)
	var target = self.get_random_player(targets)
	
	var skill1_effect = preload("res://scenes/skill/jjambbong_skill1.tscn").instantiate()
	
	var animated_sprite = target.get_node("AnimatedSprite2D")
	
	target.add_child(skill1_effect)
	
	target.take_damage(calculate_inflicted_damage(30), skill_1_settings.target_direction)
	target.plus_damage_frame(3)
	
	skill1_effect.get_node("AnimatedSprite2D").frame = 0
	skill1_effect.get_node("AnimatedSprite2D").play()
		
		

func skill_2(team, enemies, turn, meta):
	# 스킬 2 (발동 15, 2턴 지속)
	# 모든 상대에게 5데미지를 주고 방어력을 10 깎습니다.
	super(team, enemies, turn, meta)
	
	var skill2_effect = preload("res://scenes/skill/jjambbong_skill2.tscn").instantiate()
	
	var enemies_panel: Control
	if _team == Settings.ATTACK_TEAM_CODE:
		enemies_panel = get_tree().get_root().get_node("Battle/defense_panel")
	else:
		enemies_panel = get_tree().get_root().get_node("Battle/attack_panel")
	
	var panel_center: Vector2 = enemies_panel.size / 2
	panel_center = panel_center + Vector2(0, enemies_panel.global_position.y)
	
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
		
		enemy.instance_node.take_damage(calculate_inflicted_damage(5), skill_2_settings.target_direction)
		enemy.instance_node.defense += -10
		enemy.instance_node.add_skill_effect(effect)
		
	skill2_effect.position = panel_center - enemies_panel.get_viewport().canvas_transform.origin

	enemies_panel.add_child(skill2_effect)
	skill2_effect.get_node("AnimatedSprite2D").frame = 0
	skill2_effect.get_node("AnimatedSprite2D").play()
