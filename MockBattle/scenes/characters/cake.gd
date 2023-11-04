extends "res://scenes/characters/player.gd"

const Player = preload("res://scenes/characters/player.gd")

func _ready():
	set_health(180)
	
	defense = 40
	resistance = 10
	evasion = 0
	critical_chance = 0
	
func get_is_enemy(target: Player):
	return target.get_team() != self.get_team()
	
func get_most_unheath_food(instance_map):
	var target: Player = null
	
	for key in instance_map:
		var food: Player = instance_map[key].instance_node
		var is_enemy: bool = get_is_enemy(food)
		
		if (is_enemy and target == null) or (is_enemy and food.get_health() < target.get_health()):
			target = food
			
	return target
	
func get_enemies_at_selected_area(area: int, instance_map):
	var target_list = []
	
	for key in instance_map:
		var instance = instance_map[key]
		var food: Player = instance.instance_node
		
		if get_is_enemy(food) and area == instance.area:
			target_list.append(food)
		
	return target_list
	
		
func skill_1(instance_map):
	# 스킬 1 (발동 13)
	# 체력이 가장 낮은 상대에게 
	# 데미지 35를 줍니다.
	
	var target = get_most_unheath_food(instance_map)
	
	target.take_damage(35)
	
func skill_2(instance_map):
	# 스킬 2 (발동 18)
	# 1열에 있는 음식들에게 데미지 15를 줍니다.
	
	var enemies = get_enemies_at_selected_area(0, instance_map)
	
	for enemy in enemies:
		enemy.take_damage(15)
