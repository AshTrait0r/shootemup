extends Node

var words = [
	"привет",
	"пока",
	"мама",
	"папа",
	"дядя",
	"орех",
	"билал",
	"курица",
	"овца",
	"дерево",
	"куст",
	"скелет",
	"некромант",
	"бегемот",
	"абориген",
	"орк",
	"кролик",
	"слон",
	"зомби",
	"волшебник",
	"чудо",
	"магия",
	"стрела",
	#"write",
	#"while",
	#"letter",
	#"before",
	#"name",
	#"night",
	#"must",
	#"mean",
	#"home",
	#"which",
	#"time",
	#"left",
	#"make",
	#"year",
	#"around",
	#"story",
	#"sometimes",
	#"group",
	#"took",
	#"begin",
	#"mother",
	#"river",
	#"earth",
	#"some",
	#"point",
	#"give",
	#"went",
	#"give",
	#"something",
	#"without",
	#"study",
	#"miss",
	#"this",
	#"really",
	#"family",
	#"carry",
	#"know",
	#"took",
	#"read",
	#"began",
	#"year",
	#"feet",
	#"father"
]

var special_characters = [
	".",
	"!",
	"?"
]

#func load_dictionary():
	#var file = FileAccess.open("russiandicktionary.txt", FileAccess.READ)
	#var content = file.get_as_text()
	#var strarr = str_to_var(content)
	#file.close()
	#return strarr

func get_prompt() -> String:
	var word_index = randi() % words.size()
	var special_index = randi() % special_characters.size()

	var word = words[word_index]
	#var special_character = special_characters[special_index]

	var actual_word = word.substr(0, 1).to_upper() + word.substr(1).to_lower()

	return actual_word
