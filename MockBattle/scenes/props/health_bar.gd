extends Control
	
func set_progress(max_health: int, current_health: int):
	var progress = $progress
	
	progress.value = _calculate_health_percentage(max_health, current_health)

func _calculate_health_percentage(max_health, current_health) -> float:
	return (float(current_health) / float(max_health)) * 100.0
