extends Area2D

const HORIZONTAL_SPEED = 1000.0

var velocity = Vector2()
var shot_direction

func _ready():
    velocity.y = 0

func _physics_process(delta):
   
    # Move the bullet based on its velocity
    position += velocity * delta

# If direction == 1, its right, if direction == -1, its left    
func set_direction(direction):
    velocity.x = HORIZONTAL_SPEED * direction
    shot_direction = direction

func _on_EnemyBullet_body_entered(body):
    if (body.is_in_group("player")):
        if !body.isSliding && !body.isCrouched:
            body.takeDamage(shot_direction)
    queue_free()
