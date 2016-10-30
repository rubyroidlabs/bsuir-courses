# Module to store all bot text-based responses
module Responses
  START =
    "Привет. Я смогу помочь тебе сдать все лабы, чтобы мамка не ругалась.\n"\
    "Смотри список того, что я умею:\n\n"\
    "/start - выводит приветствие и описание всех доступных команд\n"\
    "/cancel - отменяет выполнение команд ввода (*/semester*, */subject*)\n"\
    "/semester - запоминает даты начала и конца семестра\n"\
    "/subject - добавляет предмет и количество лабораторных работ по нему\n"\
    "/subjectdelete - удаляет предмет\n"\
    "/submit, *я сдал*, *я сдала*, *сдал*, *сдала* - запоминает сдачу лабы\n"\
    "/status - выводит твой прогресс сдачи лаб\n"\
    '/reset - сбрасывает для пользователя все данные'.freeze

  SEM_START = 'Когда начинаем учиться?'.freeze
  SEM_END = 'Когда надо сдать все лабы?'.freeze
  SEM_OK = 'Понял, на все про все у нас *[M]* мес. и *[D]* д.'.freeze
  SEM_ERR = 'Семестр уже закончился или не начался =('.freeze

  SUBJ_NAME = 'Какой предмет учим?'.freeze
  SUBJ_COUNT = 'Сколько лаб надо сдать?'.freeze
  SUBJ_EXIST = 'Этот предмет уже добавлен'.freeze
  SUBJ_OK = 'OK'.freeze

  SUBJ_DELETE = 'Какой предмет удалить?'.freeze
  SUBJ_DELETE_OK = 'Предмет *[S]* удалён'.freeze

  STATUS_1 = 'К этому времени у тебя должно быть сдано:'.freeze
  STATUS_1_END = "\n\nТы опаздываешь со сдачей *[L]* лаб. (из *[T]*)".freeze
  STATUS_1_COOL = 'У тебя нет долгов к этому времени!'.freeze

  STATUS_2 = "\n\nОсталось сдать за семестр:".freeze
  STATUS_2_END = "\n\nОсталось *[L]* лаб. из *[T]*"\
                 "\nНе грусти, всё будет OK :D".freeze
  STATUS_2_COOL = 'У тебя сданы все лабы! Так держать!'.freeze
  STATUS_SEM_ERR = 'Не установлены границы семестра (/semester)'.freeze

  NO_SUBJ = 'Не добавлен ни один предмет (/subject)'.freeze

  SUBM_SUBJ = 'Что сдавал(а) ?'.freeze
  SUBM_LAB = 'Какую лабу?'.freeze
  SUBM_OK = 'Сдал(а) *[N]* лабу по *[S]*. Молодец!'.freeze
  SUBM_COOL = 'У тебя сданы все лабы! Красава :D'.freeze

  RESET = "Данные будут удалены *безвозвратно*.\nВы уверены?".freeze
  RESET_OK = 'Все данные удалены'.freeze

  NO_CMD = 'Команда не найдена =('.freeze

  CANCEL = 'Отменено'.freeze
  NO_CANCEL = 'Нечего отменять'.freeze

  CANCEL_BUTTON_TEXT = '[Отменить]'.freeze
end
