extends Node

var score = 0.0
var dogs = 0
 
func score_up(meat_type: Util.MEAT_STATE):
	match meat_type:
		Util.MEAT_STATE.RAW:
			score += 0.5
		Util.MEAT_STATE.COOKED:
			score += 10
		Util.MEAT_STATE.BURNED:
			score += 1
