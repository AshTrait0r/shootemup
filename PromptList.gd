extends Node


var allwords = []

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

func load_dictionary() -> Array:

	var current_language = Global.current_language
	var file = FileAccess.open("assets/englishdictionary.txt", FileAccess.READ)

	if current_language == "rus":
		file = FileAccess.open("assets/russiandicktionary.txt", FileAccess.READ)
	if current_language == "eng":
		file = FileAccess.open("assets/englishdictionary.txt", FileAccess.READ)
		
	var content = file.get_as_text()
	var strarr = content.split("\n")
	file.close()
	return strarr

func get_prompt() -> String:
	
	if allwords.is_empty():
		allwords = load_dictionary()
	
	var word_index = randi() % allwords.size()
	var special_index = randi() % special_characters.size()

	var word = allwords[word_index]
	if word == "":
		word = allwords[word_index-1]
	#var special_character = special_characters[special_index]

	var actual_word = word.substr(0, 1).to_upper() + word.substr(1).to_lower()

	return actual_word
