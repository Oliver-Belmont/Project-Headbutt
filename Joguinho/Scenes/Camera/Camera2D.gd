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
func slide_zoom_in():
    zoomSpeed = 5.0
    zoomTarget = Vector2(0.5, 0.5)
    
func reset_zoom():
    zoomSpeed = 2.0
    zoomTarget = Vector2(1, 1)
    
func zoom_out_death():
    zoomSpeed = 0.1
    zoomTarget = Vector2(2, 2)
    
func zoom_in_death():
    zoomSpeed = 5.0
    zoomTarget = Vector2(0.3, 0.3)
    
func zoom_hero_moment():
    zoomSpeed = 10
    zoomTarget = Vector2(0.5, 0.5)
    
func zoom_dive_moment():
    zoomSpeed = 0.2
    zoomTarget = Vector2(0.3, 0.3)
    
func zoom_dive_over():
    zoomSpeed = 0.3
    zoomTarget = Vector2(1, 1)