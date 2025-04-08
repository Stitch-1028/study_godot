extends Node2D

var bullet_scene = preload("res://子弹/bullet.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_shot_bullet(x,y) -> void:
	var bullet = bullet_scene.instantiate()
	bullet.position = Vector2(x + 17,y + 7)
	bullet.name = "Bullet"
	add_child(bullet)
