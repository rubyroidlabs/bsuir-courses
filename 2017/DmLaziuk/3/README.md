Домашнее задание 3
==================

В рамках текущего задания предлагается написать telegram-бот для определения известных людей,
которые совершили каминг-аут.

Можно присылать боту транслитерацию имени и фамилии или просто фамилию
и бот должен предлагать варианты или угадывать что вы имели ввиду.
  
### Решение

Инструкции по созданию бота и деплой его в Heroku описаны [здесь](https://github.com/barbaramartina/ruby-telegram-bot)

Использовались данные
[английской](https://en.wikipedia.org/wiki/List_of_gay,_lesbian_or_bisexual_people)
и [русской](https://ru.wikipedia.org/wiki/Проект:ЛГБТ/Списки/Известные_лесбиянки,_геи_и_бисексуалы_России) wikipedia.org,
а также [IMDB.com](http://www.imdb.com/list/ls072706884/).
Итого в базе 3268 уникальных персон.

Данные после парсинга интернет страниц хранятся в базе данных Redis в следующем порядке:

```
lgbt:index (String) -- текущий индекс (увеличивается при добавлении)

lgbt:__index__ (Hash) -- данные по конкретному человеку
               name:  -- полное имя
               uri:   -- ссылка
               note:  -- данные о coming out

lgbt:name:__name__ (List) -- список индексов вхождения данного единичного имени в полное имя

```

Напримпер после парсинга двух полных имен "Kevin Spacey" и "Kevin Williamson"
будут созданы следующие элементы (lgbt:index => "13")

```
lgbt:13 =>
    name: "Kevin Spacey"
    uri:  "...some uri..."
    note: "...some note..."
lgbt:name:kevin => "13"
lgbt:name:spacey => "13"

lgbt:14 =>
    name: "Kevin Williamson"
    uri:  "...some uri..."
    note: "...some note..."
lgbt:name:kevin => "13" "14"
lgbt:name:williamson => "14"
```

Также в момент парсинга создается Ferret индекс для неявного поиска (fuzzy search).

При обработке запросов сначала проходит поиск по единичным именам в базе Redis,
если ничего не найдено, то запускается неявный поиск Ferret с транслитерацией полного имени.

Данный бот запущен на [heroku.com](https://herokuapp.com) и доступен в Telegram [@cominoutbot](https://t.me/cominoutbot)

При написании бота использовалась следующая литература:

1. [Маленькая книга о Redis](https://github.com/kondratovich/the-little-redis-book/blob/master/ru/redis-ru.pdf)

2. [Ferret](https://www.safaribooksonline.com/library/view/ferret/9780596519407/?utm_medium=referral&utm_campaign=publisher&utm_source=oreilly&utm_content=buybox)
