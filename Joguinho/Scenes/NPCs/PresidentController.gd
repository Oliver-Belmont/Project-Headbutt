extends RigidBody2D

onready var worldNode = get_tree().get_root().get_node("World")

var wasHit = false

func _ready():
    self.connect("body_entered", self, "was_hit")

func was_hit(body):
    if body.is_in_group("player") && wasHit == false:
        wasHit = true
        print("President was saved!")
        worldNode.finish_game_win()
