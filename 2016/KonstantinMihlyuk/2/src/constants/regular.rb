# Class which contains all regulars
class Regular
  DATE = /^((0[1-9]|[12]\d)-(0[1-9]|1[012])|(30-0[13-9]|1[012])|(31-0[13578]|1[02]))-20\d\d$/
  SUBJECT_NAME = /^[A-Za-zА-Яа-я\s]+$/
  LABS_COUNT = /^\d+$/
  REMIND_TIME = /^([А-Яа-я]+) (((0[0-9]|1[0-9]|2[0-4])|[0-9])\.([0-5][0-9]|60))$/
end
