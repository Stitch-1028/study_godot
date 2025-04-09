extends Label
@export var count  = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "当前得分：" + str(count)

func _on_Slimer_slimer_destroyed():
	count += 1
