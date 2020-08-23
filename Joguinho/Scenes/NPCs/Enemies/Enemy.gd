extends KinematicBody2D

const BulletResource = preload("res://Scenes/NPCs/Enemies/EnemyBullet.tscn")

const GRAVITY = 4000.0
const WALK_SPEED = 50.0
const RUN_SPEED = 200.0
const JUMP_FORCE = 1000.0
const GUN_COOLDOWN = 1.0


var horizontalSpeed
var velocity = Vector2()
# 1 = right, -1 = left
var direction = 1
var leftArea
var rightArea
var health = 1
var timeToShoot = 0
var lockedIn = false
var worldNode
var playerNode
var stop = false

func _ready():
    worldNode = get_tree().get_root().get_node("World")
    playerNode = worldNode.get_node("Character")
    playerNode.connect("player_death", self, "stop")
    horizontalSpeed = WALK_SPEED
    $Timer.start()
    velocity.y = 0
    leftArea = $Left
    rightArea = $Right
    leftArea.set_process(false)
    
func stop():
    stop = true
    

func _process(delta):
    if (!stop):
        if lockedIn:
            if timeToShoot <= 0:
                shoot(direction)
        if timeToShoot > 0:
            timeToShoot -= delta

func _physics_process(delta):    
    if (!stop):
        if !is_on_floor():
            velocity.y += delta * GRAVITY
    
        velocity.x = direction * horizontalSpeed
        # Move the character
        move_and_slide(velocity, Vector2(0, -1))

func takeDamage():
    health -= 1
    if health == 0:
        queue_free()

func switchDirection():
    direction = direction * -1

func _on_Timer_timeout():
    switchDirection()
    $Timer.wait_time = randi() % 3 + 3
    $Timer.start()


func _on_Left_body_entered(body):
    if(body.is_in_group("player")):
        $Timer.stop()
        direction = -1
        lockedIn = true
        horizontalSpeed = RUN_SPEED


func _on_Right_body_entered(body):
    if(body.is_in_group("player")):
        $Timer.stop()
        direction = 1
        lockedIn = true
        horizontalSpeed = RUN_SPEED

func _on_Left_body_exited(body):
    if(body.is_in_group("player")):
        horizontalSpeed = WALK_SPEED
        lockedIn = false
        $Timer.start()


func _on_Right_body_exited(body):
    if(body.is_in_group("player")):
        horizontalSpeed = WALK_SPEED
        lockedIn = false
        $Timer.start()

func shoot(direction):
    var offset
    # Instance a new bullet
    var bullet = BulletResource.instance()
   
    # Set bullet direction and starting position 
    bullet.set_direction(direction)
    bullet.transform = self.transform
    offset = Vector2(33*direction, 0)
    bullet.translate(offset)
    
    # Add to world
    worldNode.add_child(bullet)
    timeToShoot = GUN_COOLDOWN
