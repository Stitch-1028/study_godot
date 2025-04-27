extends Area2D

@export var x_position = 'right'
var target_position: Vector2  # 目标位置（鼠标点击坐标）
var velocity = Vector2.ZERO
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
	if config.get('big'):
		scale = Vector2(15,15)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += velocity * delta
	
