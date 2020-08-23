extends Area2D

const HORIZONTAL_SPEED = 1000.0

var velocity = Vector2()

func _ready():
    velocity.y = 0

func _physics_process(delta):  
    # Move the bullet based on its velocity
    position += velocity * delta

# If direction == 1, its right, if direction == -1, its left    
func set_direction(direction):
    velocity.x = HORIZONTAL_SPEED * direction

func _on_Bullet_body_entered(body):
    if (body.is_in_group("enemy")):
        body.takeDamage()
    queue_free()
