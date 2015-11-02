Dir['../lib/*.rb'].each { |f| require_relative f }

parser = Parser.new
parser.parse

fetcher = TeachersFetcher.new parser.group_number
fetcher.fetch_teachers

rev = ReviewsFetcher.new fetcher.teachers
rev.teachers_reviews

sentimentor = SentimentDetector.new rev.reviews
sentimentor.detect_all

printer = Printer.new sentimentor.reviews
printer.to_console
