extends TextureButton

func _ready():
	self.connect("pressed", $"../..", "reveal", [self])
