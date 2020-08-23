extends RigidBody2D

var wasHit = false

func _ready():
    self.connect("body_entered", self, "was_hit")

func was_hit(body):
    if body.is_in_group("player") && wasHit == false:
        wasHit = true
        print("President was hit!")
