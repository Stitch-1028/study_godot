extends CharacterBody2D

var speed = 500
var is_game_over = false
var is_flip_h = false
var last_shot_time = 0.0  # 上一次发射普通子弹的时间
var last_shot_big_time = 0.0  # 上一次发射普通子弹的时间
const SHOT_INTERVAL = 0.2  # 发射间隔时间（秒）
const BIG_SHOT_INTERVAL = 2.0
# 所有敌人停止移动
signal every_stop
# 发射子弹
signal shot_bullet


func _ready() -> void:
	#velocity = Vector2(50,0)
	$is_live_music.play()
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		# 检测左键点击
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			create_bullet({
				'clickX':event.position.x,
				'clickY':event.position.y,
			})
		# 检测右键点击
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			create_bullet({
				"is_penetrate":true,
				"big":true,
				'speed':100,
				'clickX':event.position.x,
				'clickY':event.position.y,
			})

func _physics_process(delta: float) -> void:
	if not is_game_over:
		#if Input.is_action_pressed("shot"):
			#create_bullet()
#		玉米加农炮
		#if Input.is_action_just_pressed("space"):
			#create_bullet({
				#"is_penetrate":true,
				#"big":true,
				#'speed':100,
				#})
#		如果点击 ← 则玩家面相左 反之则向右
		if Input.is_action_just_pressed("left"):
			is_flip_h = true
		if Input.is_action_just_pressed("right"):
			is_flip_h = false

		velocity = Input.get_vector("left","right","up","down") * speed
		$AnimatedSprite2D.set_flip_h(is_flip_h)
		
		if velocity == Vector2.ZERO:
			$AnimatedSprite2D.play("idle")
		else:
			$AnimatedSprite2D.play("run")
	
		move_and_slide()
	
	
func game_over():
	is_game_over = true
	every_stop.emit()
	$is_live_music.stop()
	if not $is_death.is_playing():
		$is_death.play()
	$AnimatedSprite2D.play("over")
#	释放信号，将有史莱姆全部停止移动
	await get_tree().create_timer(3).timeout
	get_tree().reload_current_scene()

func create_bullet(config = {}):
	var default_config = {
		'big':false,
		'time':1000.0,
		"is_penetrate":false,
		'x':global_position.x,
		'y':global_position.y,
		'player_x':position.x,
		'player_y':position.y
	}
	default_config.merge(config,true)
	
# 计算当前时间
	var current_time = Time.get_ticks_msec()  / default_config.get("time")  # 将毫秒转换为秒
	 # 检查是否达到发射间隔
	var INTERVAL
	var SHOT_TIME
	if default_config.get('big'):
		INTERVAL = BIG_SHOT_INTERVAL
		SHOT_TIME = last_shot_big_time
	else:
		INTERVAL = SHOT_INTERVAL
		SHOT_TIME = last_shot_time
	if current_time - SHOT_TIME >= INTERVAL:
		shot_bullet.emit(default_config)
		$shot_music.play(0.1)
		if default_config.get('big'):
			last_shot_big_time = current_time
		else:
			last_shot_time = current_time
