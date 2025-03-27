extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#从 AnimatedSprite2D 的 sprite_frames 属性中获取动画名称的列表
	#返回的是一个数组，该数组包含三个动画名称：["walk", "swim", "fly"]
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
#	将前的动画随机选择一个
	$AnimatedSprite2D.animation = mob_types.pick_random()
	print(mob_types.pick_random())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
