extends CharacterBody2D

var speed = 100
var is_game_over = false
# 所有敌人停止移动
signal every_stop
# 发射子弹
signal shot_bullet


func _ready() -> void:
	#velocity = Vector2(50,0)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not is_game_over:
		
		if Input.is_action_just_pressed("shot"):
			shot_bullet.emit(position.x,position.y)
		
		velocity = Input.get_vector("left","right","up","down") * speed
		
		if Input.is_action_just_pressed("space"):
			speed += 100
		
		if velocity == Vector2.ZERO:
			$AnimatedSprite2D.play("idle")
		else:
			$AnimatedSprite2D.play("run")
	
		move_and_slide()
	
	
func game_over():
	is_game_over = true
	$AnimatedSprite2D.play("over")
#	释放信号，将有史莱姆全部停止移动
	every_stop.emit()
	await get_tree().create_timer(3).timeout
	get_tree().reload_current_scene()
