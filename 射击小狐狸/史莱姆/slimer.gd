extends Area2D

@export var slimer_speed = -100
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
	if area.name == "Bullet":
		queue_free()
		area.queue_free()
