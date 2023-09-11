extends Label

var coins = 0
var total_coins = 0

func _ready():
	#get the text property from counter
	text = str(coins)
	#get all the coins in the scene
	total_coins = get_node("/root/Level/Coins").get_child_count()
	

func _on_coin_collected():
	coins += 1
	text = str(coins)
	if coins == total_coins:
		#Adding a bit of delay
		$Timer.start()


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Assets/Scenes/Win.tscn")
