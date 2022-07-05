class_name Conversation

signal new_output(new_output)
signal new_options(new_options)

var _dialogue

func start(dialog_file: String) -> void:
	_dialogue = ClydeDialogue.new()
	_dialogue.load_dialogue(dialog_file)

	_dialogue.connect("event_triggered", self, '_on_event_triggered')
	_dialogue.connect("variable_changed", self, '_on_variable_changed')
	_get_next_dialogue_line()


func select_option(id: int, label: String) -> void:
	emit_signal("new_output", label)
	_dialogue.choose(id)
	_get_next_dialogue_line()


func _get_next_dialogue_line():
	var content = _dialogue.get_content()
	
	if not content:
		return

	if content.type == 'line':
		_set_up_line(content)
		_get_next_dialogue_line()
	else:
		_set_up_options(content)


func _set_up_line(content):
	emit_signal("new_output", "%s: %s" % [content.speaker, content.text])
	emit_signal("new_options", [])


func _set_up_options(options):
	var new_options = []
	var index = 0
	for option in options.options:
		new_options.append({"text": option.label, "id": index})
		index += 1
	emit_signal("new_options", new_options)


func _on_event_triggered(event_name):
	Game.logger.debug("Conversation event received: %s" % event_name)


func _on_variable_changed(variable_name, new_value, previous_value):
	Game.logger.debug("Conversation variable changed: %s old %s new %s" % [variable_name, previous_value, new_value])
