extends Area2D

@export var slimer_speed = -100
signal get_point
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += Vector2(slimer_speed,0) * delta

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
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
