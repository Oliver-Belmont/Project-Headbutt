extends Node2D

var playerNode

func _ready():
    # Connect to player's death signal
    playerNode = get_parent().get_node("Character")
    playerNode.connect("player_death", self, "stop_enemies")
    pass

# For each enemies in the stage, call Stop when the player dies
func stop_enemies():
    for enemy in self.get_children():
        if (enemy.is_in_group("enemy")):
            enemy.stop()
        
