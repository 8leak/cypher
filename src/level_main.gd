extends Node2D

onready var dialog_panel := find_node("DialogPanel")
var current_conversation := Conversation.new()


func _ready() -> void:
	current_conversation.connect("new_output", self, "_on_new_conversation_output")
	current_conversation.connect("new_options", self, "_on_new_conversation_options")
	dialog_panel.connect("option_button_pressed", self, "_on_dialog_panel_option_pressed")
	current_conversation.start()


func _on_new_conversation_output(new_output: String) -> void:
	dialog_panel.add_output(new_output)


func _on_new_conversation_options(options: Array) -> void:
	dialog_panel.clear_option_buttons()
	for option in options:
		dialog_panel.add_option_button(option.text, option.id)


func _on_dialog_panel_option_pressed(id: int) -> void:
	current_conversation.select_option(id)
