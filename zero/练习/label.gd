extends Label

const title = 'hello world'
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	var newTitle = sss('我是傻逼')
	self.text = newTitle
	print(newTitle)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func sss(str) -> String:
	return str
