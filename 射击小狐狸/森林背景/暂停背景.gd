extends Panel


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func game_stop():
	show()
	get_tree().paused = true
	
func game_running():
	hide()
	get_tree().paused = false


func _on_继续游戏_pressed() -> void:
	game_running()


func _on_退出游戏_pressed() -> void:
	get_tree().quit()
