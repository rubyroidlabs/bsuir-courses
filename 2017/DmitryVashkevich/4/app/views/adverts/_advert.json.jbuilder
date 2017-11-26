json.extract! advert, :id, :tittle, :description, :type,
              :phone, :name, :created_at, :updated_at
json.url advert_url(advert, format: :json)
