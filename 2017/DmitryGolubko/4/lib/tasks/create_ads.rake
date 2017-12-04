namespace :create_ads do
  desc "generate 100 fake ads"
  task create_ads: :environment do
    require 'faker'
    100.times do
    	ad = Ad.new
    	ad.title = "Will convert #{Faker::Number.number(2)} bontsicks to #{Faker::Base.regexify(/[1-9]/)} bitcoin(s)"
    	ad.text =	"#{ad.title}. #{Faker::Address.city}, #{Faker::Address.street_address}"
      ad.contact = "#{Faker::Name.name}, #{Faker::Base.regexify(/ +375 (29|44|25|33) [1-9]\d{2} \d{2} \d{2}/)}"
    	ad.save
    	p ad
    end
  end

end
