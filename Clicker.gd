extends Control

#Main Button and Score
var score = 0
var click_power = 1
var current_level = 1

#Auto-Clicker
var auto_clicker_power = 0
var auto_click_timer = null
var auto_click_price = 10

var upgrade_price = 10

#Levels
const LEVEL_1 = 10
const LEVEL_2 = 20
const LEVEL_3 = 40
const LEVEL_4 = 80
const LEVEL_5 = 160

func _ready():
	update_buttons()

#Main Button
func _on_button_pressed():
	score += click_power
	$ScoreLabel.text = str(score)
	var tween = create_tween()
	tween.tween_property($Button, "scale", Vector2(0.8, 0.8), 0.1)
	tween.tween_property($Button, "scale", Vector2(1.0, 1.0), 0.1)
	
	check_level_up()
	update_buttons()

#Level Up
func check_level_up():
	if score >= LEVEL_5:
		modulate = Color.ORCHID
	
	elif score >= LEVEL_4:
		modulate = Color.PALE_VIOLET_RED
	
	elif score >= LEVEL_3:
		modulate = Color.BROWN
	
	elif score >= LEVEL_2:
		modulate = Color.ORANGE
	
	update_buttons()

#Upgrade Button
func _on_upgrade_button_pressed():
	if score >= upgrade_price:
		score -= upgrade_price
		click_power += 1
		upgrade_price = int(upgrade_price * 1.5)
		$ScoreLabel.text = str(score)
		$UpgradeButton.text = "Upgrade (" + str(upgrade_price) + ")"
		
		var tween = create_tween()
		tween.tween_property($UpgradeButton, "scale", Vector2(0.9, 0.9), 0.1)
		tween.tween_property($UpgradeButton, "scale", Vector2(1.0, 1.0), 0.1)
		
		update_buttons()

#Auto-Click Timer
func _on_auto_clicker_timer_timeout() -> void:
	score += auto_clicker_power
	$ScoreLabel.text = str(score)
	check_level_up()
	
	update_buttons()

#Auto-Clicker buy Button
func _on_auto_click_button_pressed():
	if score >= auto_click_price:
		score -= auto_click_price
		auto_clicker_power += 1
		auto_click_price = int(auto_click_price * 2.0)
		$ScoreLabel.text = str(score)
		$AutoClickButton.text = "Auto-clicker (" + str(auto_click_price) + ")"
		
		var tween = create_tween()
		tween.tween_property($AutoClickButton, "scale", Vector2(0.9, 0.9), 0.1)
		tween.tween_property($AutoClickButton, "scale", Vector2(1.0, 1.0), 0.1)
		
		if  $AutoClickTimer.is_stopped():
			$AutoClickTimer.start()
		
		update_buttons()

func update_buttons():
	$UpgradeButton.disabled = score < upgrade_price
	$AutoClickButton.disabled = score < auto_click_price
