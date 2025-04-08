extends Node

@export var mob_scene: PackedScene
var score
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()
	#pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func game_over() -> void:
	$"HUD".show_game_over()
	$"怪物生产频率".stop()
	$"每秒增加分数".stop()

func new_game():
	score = 0
	$Player.start($"玩家起始位置".position)
	$"HUD".update_score(score)
	$"HUD".show_message("Get Ready")
	get_tree().call_group("mobs","queue_free")
	$"开始之前的延迟".start()


func _on_开始之前的延迟_timeout() -> void:
	$"怪物生产频率".start()
	$"每秒增加分数".start()

func _on_每秒增加分数_timeout() -> void:
	score += 1
	$"HUD".update_score(score)


func _on_怪物生产频率_timeout() -> void:
	# 怪物实例化
	var mob = mob_scene.instantiate()
	# 随机路线
	var mob_spawn_location = $"怪物路径/MobSpawnLocation"
	mob_spawn_location.progress_ratio = randf()
	mob.position = mob_spawn_location.position
	
	var direction = mob_spawn_location.rotation + PI / 2
	
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	add_child(mob)





func _on_ui界面_start_game() -> void:
	new_game()
