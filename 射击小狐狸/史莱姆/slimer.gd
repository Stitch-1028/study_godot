extends Area2D

@export var slimer_speed = 100
signal get_point
var player: CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_meta("type","Slimer")


func _physics_process(delta: float) -> void:
	if player:
		# 计算移动方向
		var direction = (player.global_position - global_position).normalized()
		# 更新位置
		position += direction * slimer_speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and $AnimatedSprite2D.animation != 'die':
		body.game_over()


func _on_player_every_stop() -> void:
	slimer_speed = 0 # Replace with function body.

#遇到子弹消失
func _on_area_entered(area: Area2D) -> void:
	if area.has_meta("type") and area.get_meta("type") == "Bullet" and $AnimatedSprite2D.animation != 'die':
		$shot_donw.play()
		$AnimatedSprite2D.play("die")
		slimer_speed = 0
#		如果子弹具有穿透性则不会消失
		if not area.config.get('is_penetrate'):
			area.queue_free()
		await get_tree().create_timer(1).timeout
		queue_free()
		get_point.emit()

func on_stop():
	slimer_speed = 0
	pass


func _on_timer_timeout() -> void:
#	每过一秒钟 史莱姆速度会增加100
	slimer_speed += 100
