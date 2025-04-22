extends Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_开始游戏_pressed() -> void:
	get_tree().change_scene_to_file("res://森林背景/主场景.tscn")
	print("开始游戏啦")
	pass # Replace with function body.


func _on_退出游戏_pressed() -> void:
	print("退出游戏啦")
	pass # Replace with function body.
