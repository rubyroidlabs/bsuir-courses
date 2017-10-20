Homework 2
==========
Выводит результаты всех битв [King of the Dot](https://www.youtube.com/user/KingOfTheDot) с сайта [Genius.com](https://genius.com/artists/King-of-the-dot)


### Level 1

Критерий: количество букв, произнесенных каждым участником.

Запуск:
```
$ ruby kotd.rb
```

### Level 2

Добавлена возможность выбирать результаты по имени участника.

Запуск:
```
$ NAME=DNA ruby kotd.rb
```


### Level 3

Добавлена возможность динамически выбирать критерий, по которому будет оцениваться победил рэпер или нет.

Запуск:
```
$ NAME=DNA CRITERIA=you ruby kotd.rb
```

Также можно запустить всех участников с критерием:
```
$ CRITERIA=you ruby kotd.rb
```
