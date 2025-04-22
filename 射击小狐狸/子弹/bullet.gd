extends Area2D

@export var x_position = 'right'
#var is_bullet = true
# 子弹的属性
var config = {
#	默认速度
	'speed':300,
	"is_bullet":true,
#	穿透属性
	"is_penetrate":false,
#	玉米加农炮
	"big":false
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_meta("type","Bullet")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += Vector2(get_bullet_speed(),0)  * delta
	
	if config.get('big'):
		scale = Vector2(15,15)
	
func get_bullet_speed() -> int:
	if x_position == 'right':
		return config.get('speed')
	else:
		return -config.get('speed')
