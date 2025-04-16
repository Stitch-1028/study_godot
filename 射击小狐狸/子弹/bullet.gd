extends Area2D

@export var x_position = 'right'
var is_bullet = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_meta("type","Bullet")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += Vector2(get_bullet_speed(),0)  * delta
	
func get_bullet_speed() -> int:
	if x_position == 'right':
		return 300
	else:
		return -300
