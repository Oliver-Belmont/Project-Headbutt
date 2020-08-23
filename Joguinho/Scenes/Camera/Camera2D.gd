extends Camera2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var zoomSpeed = 2.0
var zoomTarget = Vector2(1, 1)

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


func _physics_process(delta):
    self.zoom = self.zoom.linear_interpolate(zoomTarget, delta * zoomSpeed)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
func slideZoomIn():
    zoomSpeed = 5.0
    zoomTarget = Vector2(0.5, 0.5)
    
func resetZoom():
    zoomSpeed = 2.0
    zoomTarget = Vector2(1, 1)
    
func zoomOutDeath():
    zoomSpeed = 0.1
    zoomTarget = Vector2(2, 2)
    
func zoomInDeath():
    zoomSpeed = 5.0
    zoomTarget = Vector2(0.3, 0.3)