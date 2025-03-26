extends Sprite2D

var angular_speed = PI
var speed = 400
var direction = 0

func _init() -> void:
	print("hello world!")

func _process(delta: float) -> void:
	#if Input.is_action_pressed("ui_left"):
		#direction = -1
	#if Input.is_action_pressed("ui_right"):
		#direction = 1	
	rotation += angular_speed  * delta
	var velocity = Vector2.UP.rotated(rotation) * speed
	position += velocity * delta
	
	
# 在使用码连接信号时，使用Timer节点当做定时器，每当定时器到达一定时间时，将帮你触发相应函数
func _ready() -> void:
#	获取定时器Timer阶段 
#	%get_node函数只会获取当前节点下子节点%
	var timer = get_node("BlinkingTimer")
#	将自己定义的函数传递给Timer 当做息订阅
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	visible = not visible


func _on_旋转小乌龟_health_depleted(health) -> void:
	print("1号小乌龟死咯",health)
	pass # Replace with function body.
