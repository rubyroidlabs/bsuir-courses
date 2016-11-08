DATE_FORMAT_ERROR = "
Incorrect date format! Available formats:
dd-mm-yyyy
dd.mm.yyyy
dd/mm/yyyy.
Try again.
".freeze

SEMESTER_DATE_ERROR = "
The end of the semester cannot be earlier than its beginning.
Try again.
".freeze

LABS_COUNT_FORMAT_ERROR = "
Incorrect number of labs.
Try again.
".freeze

SUBJECT_FORMAT_ERROR = "
Do not user forward slashes in subjects names.
Try again.
".freeze

class DateFormatError < StandardError
end

class SemesterDateError < StandardError
end

class LabsCountFormatError < StandardError
end

class EmptySubjectError < StandardError
end

class SubjectFormatError < StandardError
end
