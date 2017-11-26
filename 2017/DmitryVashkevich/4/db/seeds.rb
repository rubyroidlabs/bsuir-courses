15.times do
  advert = Advert.new(tittle: 'Продажа биткоинов',
                      description: 'Описание',
                      currency: 'bitcoins',
                      count: 2)
  advert.create_user(name: 'Дмитрий', phone: '+375293332211')
  advert.save
end

15.times do
  advert = Advert.new(tittle: 'Продажа бонстиков',
                      description: 'Описание',
                      currency: 'bonsticks',
                      count: 5000)
  advert.create_user(name: 'Дмитрий', phone: '+375293332211')
  advert.save
end
