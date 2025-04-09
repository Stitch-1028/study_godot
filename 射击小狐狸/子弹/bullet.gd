extends Area2D

@export var bullet_speed = 300
var is_bullet = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_meta("type","Bullet")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += Vector2(bullet_speed,0)  * delta
	
