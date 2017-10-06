User.delete_all
Word.delete_all
Phrase.delete_all

User.create([
              { user_id: 1, name: "Vladimir", password: "1234" },
              { user_id: 2, name: "Igor", password: "1234" },
              { user_id: 3, name: "Pasha", password: "1234" }
            ])

phrases = []
(1..10).each do |i|
  attributes = []
  sentence = [Faker::Lorem.sentences(3, true).join(" ")]
  splits = sentence.first.gsub(/[.,]/, "").downcase.split(/\s+/)
  splits.first.capitalize!

  splits.each do |word|
    attributes << { user_id: rand(User.all.count) + 1, content: word }
  end
  phrases << { phrase_id: i, words_attributes: attributes }
end

Phrase.create(phrases)
