extends Node

@export var mob_scene: PackedScene
var score
const text = "当前分数 {score}"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()
	#pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$"计分板".text = text.format({"score":score})
	pass


func game_over() -> void:
	$"怪物生产频率".stop()
	$"每秒增加分数".stop()

func new_game():
	score = 0
	$Player.start($"玩家起始位置".position)
	$"开始之前的延迟".start()


func _on_开始之前的延迟_timeout() -> void:
	$"怪物生产频率".start()
	$"每秒增加分数".start()

func _on_每秒增加分数_timeout() -> void:
	score += 1


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
