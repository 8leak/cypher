extends Node2D

var current_conversation := Conversation.new()

onready var dialog_panel := find_node("DialogPanel")

var ticks_a = ["res://data/audio/clock/tick_a_01.wav", "res://data/audio/clock/tick_a_02.wav", "res://data/audio/clock/tick_a_03.wav"]
var ticks_b = ["res://data/audio/clock/tick_b_01.wav", "res://data/audio/clock/tick_b_02.wav", "res://data/audio/clock/tick_b_03.wav"]
var current_ticks = ticks_a


func _ready() -> void:
	current_conversation.connect("new_output", self, "_on_new_conversation_output")
	current_conversation.connect("new_options", self, "_on_new_conversation_options")
	dialog_panel.connect("option_button_pressed", self, "_on_dialog_panel_option_pressed")

	Game.calendar.connect("new_tick", self, "_on_timeline_new_tick")
	Game.calendar.connect("new_hour", self, "_on_timeline_new_hour")
	Game.calendar.connect("new_day", self, "_on_timeline_new_day")

	current_conversation.start('start_game')


func _on_new_conversation_output(new_output: String) -> void:
	dialog_panel.add_output(new_output)


func _on_new_conversation_options(options: Array) -> void:
	dialog_panel.clear_option_buttons()
	for option in options:
		dialog_panel.add_option_button(option.text, option.id)


func _on_dialog_panel_option_pressed(id: int, label: String) -> void:
	current_conversation.select_option(id, label)


func _on_timeline_new_tick(_ticks) -> void:
	var stream = Utils.choice(current_ticks)
	current_ticks = ticks_a if current_ticks == ticks_b else ticks_b
	Game.audio.one_shot(stream)
	var time = Game.calendar.get_date()
	$CanvasLayer/UIClock.set_time(time["hour"], time["minute"], time["second"])

	var time_key = "%s-%02d:%02d:%02d" % [time["day"], time["hour"], time["minute"], time["second"]]
	
	Game.timeline.check_events(time_key)

func _on_timeline_new_hour(_hour) -> void:
	Game.audio.one_shot("res://data/audio/clock/hour_01.wav")

func _on_timeline_new_day(_day) -> void:
	pass
