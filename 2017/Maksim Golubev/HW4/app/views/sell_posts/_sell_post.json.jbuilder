json.extract! sell_post, :id, :title, :body, :phone, :name, :sell_currency, :created_at, :updated_at
json.url sell_post_url(sell_post, format: :json)
