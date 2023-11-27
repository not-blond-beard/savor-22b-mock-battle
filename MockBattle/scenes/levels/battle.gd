extends Node2D

var _game_turn: int = 1

var defense_team: BattleTeam
var attack_team: BattleTeam

signal game_turn_changed(current_turn)

func _ready():
	defense_team = BattleTeam.new(Settings.DEFENSE_TEAM_CODE, Settings.defense_command, game_turn_changed)
	attack_team = BattleTeam.new(Settings.ATTACK_TEAM_CODE, Settings.attack_command, game_turn_changed)
	
	defense_team.set_func_get_enemies(attack_team.get_instance_map)
	attack_team.set_func_get_enemies(defense_team.get_instance_map)
	
	FrameCounter.frame_changed.connect(_on_frame_changed)
	FrameCounter.start_frame()
	
	batch_characters_at_areas()

func get_game_turn() -> int:
	return _game_turn
	
func set_turn(turn: int):
	_game_turn = turn
	game_turn_changed.emit(_game_turn)
	
func increase_game_turn():
	set_turn(_game_turn + 1)
	
func _on_change_scene_pressed():
	return get_tree().change_scene_to_file("res://scenes/levels/settings.tscn")

func show_winner():
	var code = get_winner_team_code()
	var winner_alert: WinnerAlert = $winner_alert
	
	winner_alert.show_winner(code)

func check_game_end() -> bool:
	if defense_team.is_over and attack_team.is_over:
		show_winner()
		return true
		
	return false

func _on_frame_changed(frame):
	if check_game_end():
		FrameCounter.stop_frame()
		return
		
	var defense_fire_skill: bool = defense_team.on_frame_changed_fire_skill(frame, get_game_turn())
	var attack_fire_skill: bool = attack_team.on_frame_changed_fire_skill(frame, get_game_turn())
	
	if defense_fire_skill or attack_fire_skill:
		increase_game_turn()
		FrameCounter.pause_frame()
		
	if defense_fire_skill:
		defense_team.clear_guard()
	
	if attack_fire_skill:
		attack_team.clear_guard()
	
func batch_characters_at_areas():
	var defnse_front_area = $defense_area/front/container
	var defnse_center_area = $defense_area/center/container
	var defnse_back_area = $defense_area/back/container
	
	var attack_front_area = $attack_area/front/container
	var attack_center_area = $attack_area/center/container
	var attack_back_area = $attack_area/back/container
	
	defense_team.batch_characters([defnse_front_area, defnse_center_area, defnse_back_area], Settings.defense_position, false)
	attack_team.batch_characters([attack_front_area, attack_center_area, attack_back_area], Settings.attack_position, true)
	

func get_winner_team_code() -> int:
	var defense_team_total_health: int = defense_team.get_team_health()
	var attack_team_total_healath: int = attack_team.get_team_health()
			
	if defense_team_total_health > attack_team_total_healath:
		return Settings.DEFENSE_TEAM_CODE
	elif defense_team_total_health < attack_team_total_healath:
		return Settings.ATTACK_TEAM_CODE
	else:
		return 0
