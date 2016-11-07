# Module to store all bot text-based responses
module Responses
  START =
    "Привет, [NAME]. Я смогу помочь тебе сдать все лабы.\n"\
    "Смотри список того, что я умею:\n\n"\
    "/start - выводит приветствие и описание всех доступных команд\n"\
    "/cancel - отменяет ожидание ввода\n"\
    "/semester - запоминает даты начала и конца семестра\n"\
    "/import - импортирует предметы из расписания БГУИР по номеру группы\n"\
    "/subject - добавляет предмет и количество лабораторных работ по нему\n"\
    "/subjectdelete - удаляет предмет\n"\
    "/submit, *я сдал*, *я сдала*, *сдал*, *сдала* - запоминает сдачу лабы\n"\
    "/status - выводит твой прогресс сдачи лаб\n"\
    "/remind - выводит диалог настройки оповещений\n"\
    '/reset - сбрасывает для пользователя все данные'.freeze

  SEM_START = 'Когда начинаем учиться?'.freeze
  SEM_END = 'Когда надо сдать все лабы?'.freeze
  SEM_OK_NOW = 'Понял, на все про все у нас осталось *[ML]* мес. и *[DL]* д.'\
               ' (а было *[MT]* мес. и *[DT]* д.)'.freeze
  SEM_OK_NOT_NOW = 'Понял, длина семестра *[MT]* мес. и *[DT]* д.'.freeze
  SEM_NOT_STARTED = 'Семестр еще не начался'.freeze
  SEM_ENDED = 'Семестр уже закончился'.freeze
  SEM_TEXT = "Семестр с *[START]* по *[END]*.\nПрошло уже *[PERC]%* семестра\n"\
             'Осталось *[ML]* мес. и *[DL]* д.'.freeze

  SUBJ_NAME = 'Какой предмет учим?'.freeze
  SUBJ_COUNT = 'Сколько лаб надо сдать по *[S]*?'.freeze
  SUBJ_EXIST = 'Этот предмет уже добавлен'.freeze
  SUBJ_OK = 'Предмет *[S]* добавлен (*[N]* лаб.)'.freeze

  SUBJ_DELETE = 'Какой предмет удалить?'.freeze
  SUBJ_DELETE_OK = 'Предмет *[S]* удалён'.freeze

  STATUS_1 = 'К этому времени у тебя должно быть сдано:'.freeze
  STATUS_1_END = "\n\nТы опаздываешь со сдачей *[L]* лаб. (из *[T]*)".freeze
  STATUS_1_COOL = 'У тебя нет долгов к этому времени!'.freeze

  STATUS_2 = "\n\nОсталось сдать за семестр:".freeze
  STATUS_2_END = "\n\nОсталось *[L]* лаб. из *[T]*"\
                 "\nНе грусти, всё будет OK :D".freeze
  STATUS_2_COOL = "\n\nУ тебя сданы все лабы! Так держать!".freeze
  STATUS_SEM_ERR = 'Не установлены границы семестра (/semester)'.freeze

  NO_SUBJ = 'Не добавлен ни один предмет (/subject)'.freeze

  SUBM_SUBJ = 'Что сдавал(а) ?'.freeze
  SUBM_LAB = 'Какую лабу?'.freeze
  SUBM_OK = 'Сдал(а) *[N]* лабу по *[S]*. Молодец!'.freeze
  SUBM_COOL = 'У тебя сданы все лабы! Красава :D'.freeze

  RESET = "Данные будут удалены *безвозвратно*.\nВы уверены?".freeze
  RESET_OK = 'Все данные удалены'.freeze

  WAIT_FOR_CALLBACK = "Выберите вариант из прошлого сообщения.\n"\
                      'Если вы не видите сообщения напишите /cancel'.freeze
  NO_CMD = 'Команда не найдена =('.freeze

  CANCEL = 'Отменено'.freeze
  NO_CANCEL = 'Нечего отменять'.freeze

  CANCEL_BUTTON_TEXT = '[Отменить]'.freeze

  REMINDER_ADD_START = 'Когда напоминать?'.freeze
  REMINDER_ADD_TIME = 'В какое время?'.freeze
  REMINDER_DAY_0 = '<Ежедневно>'.freeze
  REMINDER_DAY_1 = 'Понедельник'.freeze
  REMINDER_DAY_2 = 'Вторник'.freeze
  REMINDER_DAY_3 = 'Среда'.freeze
  REMINDER_DAY_4 = 'Четверг'.freeze
  REMINDER_DAY_5 = 'Пятница'.freeze
  REMINDER_DAY_6 = 'Суббота'.freeze
  REMINDER_DAY_7 = 'Воскресенье'.freeze
  REMINDER_DAY_8 = '<Рабочие дни>'.freeze
  REMINDER_DAY_9 = '<Выходные>'.freeze
  REMINDER_OK = 'Напоминание успешно добавлено (*[D]* в *[T]*)'.freeze
  REMINDER_ERR_EXIST = 'Напоминание уже существует! (*[D]* в *[T]*)'.freeze
  REMINDER_NO = 'Нет добавленных напоминаний'.freeze
  REMINDER_STAT = "Добавленные напоминания:\n".freeze
  REMINDER_ADD_BUTTON = 'Добавить напоминание'.freeze
  REMINDER_DEL_BUTTON = 'Удалить напоминание'.freeze
  REMINDER_DEL_START = "Какое напоминание удаляем?\n".freeze
  REMINDER_DEL_ERR = 'Что-то пошло не так =('.freeze
  REMINDER_DEL_OK = 'Напоминание успешно удалено (*[D]* - *[T]*)'.freeze

  REMIND = "*Напоминание*\n".freeze

  IMPORT_GROUP = 'Введите номер группы для импорта предметов'.freeze
  IMPORT_NO_GROUP = 'Неверный номер группы. Импорт отменён'.freeze
  IMPORT_NO_SUBJECTS = 'Не найдены предметы для импорта'.freeze
  IMPORT_WHAT_SUBJECTS = 'Какой предмет импортировать?'.freeze
  IMPORT_ALL_EXIST = 'Все предметы уже добавлены'.freeze
  IMPORT_STOP_BUTTON = '[Закончить импорт]'.freeze
  IMPORT_STOPPED = 'Импорт окончен'.freeze
end
