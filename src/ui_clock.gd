extends Control


func set_time(hour: int, minute: int, second: int) -> void:
	$Sprite/HourHand.rect_rotation = 180 + (30*hour)
	$Sprite/MinuteHand.rect_rotation = 180 + (6*minute)
	$Sprite/SecondHand.rect_rotation = 180 + (6*second)
