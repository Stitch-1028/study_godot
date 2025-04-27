extends Node2D

var bullet_scene = preload("res://子弹/bullet.tscn")
var slimer_scene = preload("res://史莱姆/slimer.tscn")
# Called when the node enters the scene tree for the first time.
var label_node:Label
var player : CharacterBody2D
var is_stop = false
func _ready() -> void:
	label_node = get_node("计分板")
	player = get_node("Player")
	$"定时生成史莱姆".start()
	$"暂停背景".game_running()

func _physics_process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ESC"):
		get_tree().paused = true
		$"暂停背景".game_stop()
			

func _on_player_shot_bullet(config : Dictionary) -> void:
	var x = config.get('player_x')
	var y = config.get('player_y')
	var bullet = bullet_scene.instantiate()
	bullet.config.merge(config,true)
	#bullet_scene.config.is_penetrate = config.get('is_penetrate')
#	如果人物面相 ← 则弹向左边飞 之则向右
	if $Player.is_flip_h: 
		bullet.x_position = 'left'
		bullet.position = Vector2(x - 17,y + 7)
	else:
		bullet.position = Vector2(x + 17,y + 7)
		bullet.x_position = 'right'
	# 计算方向向量
	var direction_x = config.get('clickX') - config.get('x')
	var direction_y = config.get('clickY') - config.get('y')
	var speed = bullet.config.get('speed')
	print(Vector2(direction_x, direction_y).normalized() * speed)
	bullet.velocity = Vector2(direction_x, direction_y).normalized() * speed
#	计算子弹的偏转角度
	var angle = atan2(direction_y, direction_x) # 计算弧度值
	bullet.rotate(angle)
	add_child(bullet)


func _on_定时生成史莱姆_timeout() -> void:
	if player.is_game_over:
		return
	var slimer = slimer_scene.instantiate()
	# 设置史莱姆的位置（例如，随机位置或固定位置）
	slimer.player = player
	#slimer.position = Vector2(randf_range(-400,160),randf_range(0,-200))  # 随机位置
	var side = randi() % 4
	var viewport_rect  = get_viewport_rect()
	var spawn_position: Vector2
	match side:
		0:  # 上边
			spawn_position = Vector2(randf_range(0, viewport_rect.size.x), -5)
		1:  # 下边
			spawn_position = Vector2(randf_range(0, viewport_rect.size.x), viewport_rect.size.y + 5)
		2:  # 左边
			spawn_position = Vector2(-5, randf_range(0, viewport_rect.size.y))
		3:  # 右边
			spawn_position = Vector2(viewport_rect.size.x + 5, randf_range(0, viewport_rect.size.y))
	slimer.position = spawn_position  # 设置随机位置
	
#	将史莱姆死亡的信号与计分板绑定，便于分数的相加
	slimer.connect("get_point",Callable(label_node, "_on_Slimer_slimer_destroyed"))
	player.connect("every_stop",Callable(slimer,"on_stop"))
	# 将史莱姆添加到场景树中
	add_child(slimer)
