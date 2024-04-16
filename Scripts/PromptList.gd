extends Node

var allwords: Array = []

var special_characters: Array = [
	".",
	"!",
	"?"
]

#func filter_includes(base_array: Array, length: int, filter_key: String = "") -> Array:
	#var filtered_array := []
#
	#for base_item in base_array:
		#var count: int = 0
		#var search_item: String = base_item
#
		#if filter_key:
			#search_item = base_item[filter_key]
#
		#filtered_array.append(base_item)
#
	#return filtered_array

func load_dictionary() -> Array:

	var current_language = Global.current_language
	#var file = FileAccess.open("assets/englishdictionary.txt", FileAccess.READ)

	if current_language == "rus":
		allwords = russian_words.split(",")
		#file = FileAccess.open("assets/russiandicktionary.txt", FileAccess.READ)
	elif current_language == "eng":
		allwords = english_words.split(",")
		#file = FileAccess.open("assets/englishdictionary.txt", FileAccess.READ)
		
	#var content = file.get_as_text()
	#var strarr = content.split("\n")
	#file.close()
	return allwords

func get_prompt(health: int = 4) -> String:
	
	if allwords.is_empty():
		allwords = load_dictionary()
	
	var limited_length_words: Array
	
	for word in allwords:
		if word.length() == health: 
			var actual_word = word.substr(0, 1).to_upper() + word.substr(1).to_lower()
			allwords.shuffle()
			return actual_word
			
	return "Error"
	#var word_index = randi() % allwords.size()
	#var special_index = randi() % special_characters.size()
#
	#var word:String = allwords[word_index]
	#if word == "":
		#word = allwords[word_index-1]
	#var special_character = special_characters[special_index]

	#var actual_word = word.substr(0, 1).to_upper() + word.substr(1).to_lower()

	#return actual_word

var english_words: String = "Dragon,Magic,Wizard,Elf,Dwarf,Castle,Forest,\
Fairy,Sorcery,Quest,Ruin,Prophecy,Giant,Mermaid,Animal,Potion,\
Spell,Dungeon,Artifact,Ghost,Element,Shapeshifter,Carpet,Portal,\
Clan,Time,Celestial,Temple,Curse,Creature,Divine,Alchemy,Tome,\
Maze,Centaur,Phoenix,Siren,Projection,Crystal,Sword,Ritual,Passageway,\
Goblin,Nymph,Guardian,Seer,Changeling,Dreamwalker,Elixir,Realm,Fateweaver,\
Grove,Map,Plain,Wyvern,Chaos,Ring,Necromancer,Assassin,Storm,Academy,\
Rider,Ship,Relic,Flame,Spirit,Giant,Library,Amulet,Oath,Wraith,Thread,\
Battle,Lake,Caravan,Timekeeper,Oath,Golem,Sigil,Crystal,Coven,Masquerade,\
Convergence,Cycle,Familiar,Garden,City,Stargazer,Balance,Mirror,Court,Harmony,Realm,Wind,Peace"

var russian_words: String = "Эльф,Орк,Гном,Фея,Меч,Демон,Король,Принц,Замок,Чудо,\
Закон,Тролль,Герой,Подарок,Зелье,Персонаж,Загадка,Сокровище,\
Портал,Миф,Проклятие,Путешествие,Эпос,Призрак,Легенда,Эпик,Существо,\
Кристалл,Колдун,Магия,Воин,Квест,Фантазия,Приключение,Чудовище,\
Дракон,Чудо,Магия,Таинство,Волшебник,Принцесса,Заклинание,Воинство,\
Затерянный,Сокровищница,Волшебство,Секрет,Приключение,Заклинатель"\
