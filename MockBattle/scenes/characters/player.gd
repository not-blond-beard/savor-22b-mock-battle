extends Control

var _team: int
var _health: int
# 체력 
export(int) var defense
# 방어력
export(int) var resistance
# 저항력
export(int) var evasion
# 회피력
export(int) var critical_chance
# 치명타 확률

func _ready():
	pass
	
	
func set_health_text(health: int):
	var health_text = $health_bar/health_container/health
	
	health_text.text = health as String

func set_team(team: int):
	_team = team
	
func get_team():
	return _team
	
func set_health(health: int):
	_health = health
	
	set_health_text(health)

func get_health():
	return _health
	
func take_damage(damage: int):
	var health = get_health() - damage
	
	print(damage as String + "를 입었음")
	
	set_health(health)
	
	return health
	
func skill_1(instance_map):
	pass
	
func skill_2(instance_map):
	pass

func get_is_enemy(target):
	return target.get_team() != self.get_team()
		
func get_enemies_at_selected_area(area: int, instance_map):
	var target_list = []
	
	for key in instance_map:
		var instance = instance_map[key]
		var food = instance.instance_node
		
		if get_is_enemy(food) and area == instance.area:
			target_list.append(food)
		
	return target_list

func get_all_enemies(instance_map):
	var enemies = []
	
	for key in instance_map:
		var instance = instance_map[key]
		var food = instance.instance_node
		
		enemies.append(food)
		
	return enemies
