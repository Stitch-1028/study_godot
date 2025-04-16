extends Node2D

var bullet_scene = preload("res://子弹/bullet.tscn")
var slimer_scene = preload("res://史莱姆/slimer.tscn")
# Called when the node enters the scene tree for the first time.
var label_node:Label
var player : CharacterBody2D
func _ready() -> void:
	label_node = get_node("计分板")
	player = get_node("Player")
	$"定时生成史莱姆".start()


func _process(delta: float) -> void:
	pass


func _on_player_shot_bullet(x,y) -> void:
	var bullet = bullet_scene.instantiate()
#	如果人物面相 ← 则弹向左边飞 之则向右
	if $Player.is_flip_h: 
		bullet.x_position = 'left'
		bullet.position = Vector2(x - 17,y + 7)
	else:
		bullet.position = Vector2(x + 17,y + 7)
		bullet.x_position = 'right'
	add_child(bullet)


func _on_定时生成史莱姆_timeout() -> void:
	if player.is_game_over:
		return
	var slimer = slimer_scene.instantiate()
	# 设置史莱姆的位置（例如，随机位置或固定位置）
	slimer.position = Vector2(160,randf_range(0,-70))  # 随机位置
#	将史莱姆死亡的信号与计分板绑定，便于分数的相加
	slimer.connect("get_point",Callable(label_node, "_on_Slimer_slimer_destroyed"))
	player.connect("every_stop",Callable(slimer,"on_stop"))
	# 将史莱姆添加到场景树中
	add_child(slimer)
