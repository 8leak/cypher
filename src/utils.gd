class_name Utils
extends Reference


# attempts to format a reference in a human-readable way
# - `reference`, `Reference`: the reference to print
static func pprint(reference: Reference) -> void:
	match reference.get_class():
		"Dictionary", "Array":
			print(JSON.print(reference, "  "))
		_:
			print(reference)


# return a random element from an iterable
# - choices, Iterable: the iterable to return a random element from
# - returns Variant: a random element from the iterable
static func choice(choices):
	if choices.size() > 0:
		return choices[Game.rng.randi_range(0, choices.size() - 1)]
	Game.logger.error("Invalid choice object: %s" % str(choices))
	return choices

static func load_yaml(file_path: String) -> Dictionary:
	var file = File.new()
	if not file.file_exists(file_path):
		push_error("Invalid file path: %s" % file_path)
		return {}

	file.open(file_path, File.READ)
	var content = file.get_as_text()
	file.close()
	var yaml = preload("res://addons/godot-yaml/gdyaml.gdns").new()
	var result = yaml.parse(content)
	return result.result

static func load_json(file_path: String) -> Dictionary:
	var file = File.new()
	if not file.file_exists(file_path):
		push_error("Invalid file path: %s" % file_path)
		return {}

	file.open(file_path, File.READ)
	var content = file.get_as_text()
	file.close()
	return parse_json(content)
