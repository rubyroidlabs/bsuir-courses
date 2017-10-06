WELCOMINGMESSAGE = "Привет. Меня зовут Lana👸. И я помогу тебе с учебкой🎓\n✅/semester запоминаю дату дедлайна📅\n✅/subject запоминаю предмет, по которому у тебя хвосты и их количество😊\n✅/submit (я сдал) запоминаю закрую лабу😊\n✅/status рассказываю о текущей ситуации\n✅/cancel отменяю текущую команду\n✅/reset удаляю все твои данные".freeze
MONTHS_KB = [%w(1 2 3 4), %w(5 6 7 8), %w(9 10 11 12)].freeze
DAYS_KB = [%w(1 2 3 4 5 6), %w(7 8 9 10 11 12), %w(13 14 15 16 17 18), %w(19 20 21 22 23 24), %w(25 26 27 28 29), %w(30 31)].freeze
YEAR_KB = [['2016'], ['2017']].freeze
YES_NO_KB = [['Yes✅'], ['No❌']].freeze
NEXT_COMMANDS = { '/day_input' => 'SemesterCommand',
                  '/month_input'       => 'SemesterCommand',
                  '/year_input'        => 'SemesterCommand',
                  '/reload_deadline'   => 'SemesterCommand',
                  '/add_subject'       => 'SubjectCommand',
                  '/add_count_of_labs' => 'SubjectCommand' }.freeze
COMMANDS = { '/start' => 'WelcomingCommand',
             '/semester' => 'SemesterCommand',
             '/subject'  => 'SubjectCommand',
             '/submit'   => 'Submit',
             'я сдал'    => 'Submit',
             '/status'   => 'Status',
             '/reset'    => 'Reset' }.freeze
WHAT_SUBJECT = 'По какому предмету?📙'.freeze
WHAT_LAB = 'Какая лаба?📈'.freeze
CONGRATULATIONS = 'Поздравляю👏🏻'.freeze
EMPTY_STRING = ' '.freeze
CANCELED = 'Отменено😊'.freeze
NOTHING_TO_CANCEL = 'Нечего отменять😊'.freeze
INPUT_SUBJECT_NAME = 'Введи название предмета📕'.freeze
COUNT_OF_SUBJECT_LABS = 'Количество лаб по этому предмету📊'.freeze
SUBJECT_ALREADY_EXIST_INPUT_ANOTHER = "Такой предмет уже есть🙃 \nВведи другое название".freeze
ACCEPTED = 'Принято📡'.freeze
THIS_WILL_NOT_WORK = 'Так не пойдет'.freeze
WHEN_DEADLINE = 'Когда надо все сдать?'.freeze
INPUT_YEAR = 'Введи год'.freeze
INPUT_MONTH = 'Введи месяц'.freeze
INPUT_DAY = 'Введи день'.freeze
DEADLINE_ALREADY_EXIST = "Данные о дате дедлайна присутствуют\nХочешь ввести новые данные?📀".freeze
HOW_YOU_WISH = 'Ну как хочешь😏'.freeze
UNCORRECT_DATE = 'Неправильная дата😡'.freeze
TALES_NOT_EXIST = 'Хвостов нет😱'.freeze
DELETED = 'Все твои данные удалены😊'.freeze
CANT_DELETE_NOW = 'Не могу удалить в данный момент, отмени команду(/cancel)'.freeze
CURRENT_STATE = 'На данный момент тебе осталось'.freeze
I_BELIEVE_IN_YOU = 'Я верю в тебя😚'.freeze
