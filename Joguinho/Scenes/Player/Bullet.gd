extends Area2D

const HORIZONTAL_SPEED = 1800.0

var velocity = Vector2()

func _ready():
    velocity.y = 0

func _physics_process(delta):
   
    # Move the bullet based on its velocity
    position += velocity * delta
    
func set_direction(direction):
    if (direction == "left"):
        velocity.x = -HORIZONTAL_SPEED
    elif (direction == "right"):
        velocity.x = HORIZONTAL_SPEED

func _on_Bullet_body_entered(body):
    queue_free()
