extends Area2D

class_name Player

@onready var _animated_sprite = $AnimatedSprite2D

var _team: int
var _id: int
var _health: int
var _max_health: int
# 체력 
@export var defense: int
# 방어력
@export var resistance: int
# 저항력
@export var evasion: int
# 회피력
@export var critical_chance: int
# 치명타 확률
@export var food_name: String
# 음식 이름
@export var food_type: String
# 음식 속성 (짠맛, 단맛, ...)

@export var damage_frame: int
# 데미지 프레임
@export var stun: bool
# 상태 이상 (스턴)
@export var guard_disabled: bool
@export var guard_position: int

var skill_1_settings: SkillSettings
# 스킬 1의 발동 프레임 & 지속 턴
var skill_2_settings: SkillSettings
# 스킬 2의 발동 프레임 & 지속 턴

var skill_effect: Array[SkillEffect]
			
func deactive_guard():
	guard_disabled = true
	
func active_guard():
	guard_disabled = false
	
func change_guard_position(position: int): 
	guard_position = position

func init_player_status(effect: SkillEffect):
	var origin_status: int = self.get(effect.target_stat)
	
	self.set(effect.target_stat, origin_status - effect.meta)
	
func _on_turn_changed(next_turn: int):
	var current_turn = next_turn - 1
	
	for effect in skill_effect:
		var end_turn: int = effect.started_turn + effect.persistent_turn
		
		if current_turn >= end_turn:
			skill_effect.erase(effect)
			
			if effect.type == Settings.SkillEffectType.CHANGED_PLAYER_STATUS:
				init_player_status(effect)
		
	
func add_skill_effect(skill: SkillEffect):
	skill_effect.append(skill)
	
func set_health_info(health: int):
	var health_text = $character_info/health_bar
	
	health_text.set_progress(_max_health, health)

func set_team(team: int):
	_team = team
	
func set_id(id: int):
	_id = id
	
func get_id():
	return _id
	
func get_team():
	return _team
	
func add_health(health: int):
	if get_health() <= 0:
		return
		
	set_health(get_health() + health)

func _death():
	_health = 0
	
	set_health_info(0)
	hide()
	
	
func set_health(health: int):
	if _max_health == 0:
		_max_health = health
	
	if health <= 0:
		return _death()
		
	_health = health
	set_health_info(_health)
	

func get_health():
	return _health
	
func get_random_player(targets: Array):
	if targets.size() > 0:
		var random_index = randi() % targets.size()
		var random_target = targets[random_index]
		
		return random_target

func get_matching_character_to_tanking(team: Dictionary) -> Player:
	for effect in skill_effect:
		if effect.type == Settings.SkillEffectType.PROTECT:
			return team[effect.skill_owner_id].instance_node as Player
	
	return self

# 상대방에게 공격을 입힐 때 사용할 데미지 계산
func calculate_inflicted_damage(origin_damage: int) -> int:
	var critical = GameHelper.is_probability_success(critical_chance)
	var add_damage := GameHelper.calculate_percentage(origin_damage, 40)
	
	if critical:
		return origin_damage + add_damage
	else:
		return origin_damage
	
func _calculate_guard_received_defense(origin_damage: int, positiion: int) -> int:
	if guard_disabled:
		return defense
	elif positiion == guard_position:
		if positiion == 0:
			var origin_defense = GameHelper.calculate_percentage(30, defense)
			return 70 + origin_defense
		elif positiion == 1:
			return 100
	
	return defense
		
# 내게 적용될 데미지를 계산
func _calculate_final_received_damage(origin_damage: int, positiion: int) -> int:
	if GameHelper.is_probability_success(evasion):
		return 0
		
	var result_defense: int = _calculate_guard_received_defense(origin_damage, positiion)
	var minus_damage = GameHelper.calculate_percentage(origin_damage, result_defense)
	
	return origin_damage - minus_damage
	
func _show_info():
	var label = $character_info/id_label
	
	label.text = "[{0}][{1}] {2}".format([food_type, str(get_id()), food_name])
			
func _show_skill_info(skill_type: int, description: String):
	var container = $character_info/skill_noti
	var label = $character_info/skill_noti/label
	
	label.text = "[Skill {0}]을(를) 시전했다.\n{1}".format([str(skill_type), description])
	container.show()
	
	await get_tree().create_timer(2.0).timeout
	
	container.hide()

func play_special_animation(animation: String):
	_animated_sprite.play(animation)
	
	_animated_sprite.connect("animation_finished", _on_animation_finished)
	
func _on_animation_finished():
	if _animated_sprite.is_connected("animation_finished", _on_animation_finished):
		_animated_sprite.disconnect("animation_finished", _on_animation_finished)
		
	_animated_sprite.play("idle")
	
func show_hit_info(damage: int):
	var highlight = $character_info/target_highlight
	
	highlight.show()
	
	await get_tree().create_timer(2.0).timeout
	
	highlight.hide()
	
	
func take_damage(damage: int, position: int):
	var final_damange := _calculate_final_received_damage(damage, position)
	
	show_hit_info(final_damange)
	
	if final_damange <= 0:
		return get_health()
		
	set_health(get_health() - final_damange)
	play_special_animation("hit")
	
	return get_health()
	
func check_activate_status_effect() -> bool:
	if GameHelper.is_probability_success(resistance):
		return false
		
	return true
	
func update_stun_text(toggle: bool): 
	var label = $character_info/stun_label
	
	label.visible = toggle
	
func toggle_stun(toggle: bool) -> bool:
	if toggle and !check_activate_status_effect():
		return false
		
	stun = toggle
	
	update_stun_text(stun)
	
	return stun
	
func plus_damage_frame(_damage_frame: int) -> bool:
	if !check_activate_status_effect():
		return false
		
	damage_frame += _damage_frame
	
	return true
	
func remove_damage_frame():
	damage_frame = 0
	
func skill_1(team, enemies, turn, meta):
	_show_skill_info(1, skill_1_settings.description)
	play_special_animation("attack")
	
func skill_2(team, enemies, turn, meta):
	_show_skill_info(2, skill_2_settings.description)
	play_special_animation("attack")
	
func skill_guard(team, enemies, turn, meta):
	change_guard_position(meta)

func get_is_enemy(target):
	return target.get_team() != self.get_team()
		
func get_foods_at_selected_area(area: int, instance_map):
	var target_list = []
	
	for key in instance_map:
		var instance = instance_map[key]
		var food = instance.instance_node
		
		if area == instance.area:
			target_list.append(food)
		
	return target_list
	
func get_most_unheath_food(instance_map):
	var target = null
	
	for key in instance_map:
		var food = instance_map[key].instance_node
		
		if (target == null or (food.get_health() < target.get_health())) and food.get_health() >= 0:
			target = food
			
	return target
