extends Sprite2D
#定义个信号
signal health_depleted(current_health)
var health = 10

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
	

func _on_button_pressed() -> void:
	set_process(not is_processing())
	health_depleted.emit(0)
	
