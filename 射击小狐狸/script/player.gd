extends CharacterBody2D

var speed = 100
var is_game_over = false
var is_flip_h = false
var last_shot_time = 0.0  # 上一次发射子弹的时间
const SHOT_INTERVAL = 0.2  # 发射间隔时间（秒）
# 所有敌人停止移动
signal every_stop
# 发射子弹
signal shot_bullet


func _ready() -> void:
	#velocity = Vector2(50,0)
	$is_live_music.play()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not is_game_over:
		if Input.is_action_pressed("shot"):
			# 计算当前时间
			var current_time = Time.get_ticks_msec()  / 1000.0  # 将毫秒转换为秒
			 # 检查是否达到发射间隔
			if current_time - last_shot_time >= SHOT_INTERVAL:
				shot_bullet.emit(position.x,position.y)
				$shot_music.play(0.1)
				last_shot_time = current_time
#		如果点击 ← 则玩家面相左 反之则向右
		if Input.is_action_just_pressed("left"):
			is_flip_h = true
		if Input.is_action_just_pressed("right"):
			is_flip_h = false
		velocity = Input.get_vector("left","right","up","down") * speed
		$AnimatedSprite2D.set_flip_h(is_flip_h)
		if Input.is_action_just_pressed("space"):
			speed += 100
		
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
