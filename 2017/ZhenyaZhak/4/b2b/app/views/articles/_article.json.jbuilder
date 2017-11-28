json.extract! article, :id, :headline, :text, :data, :created_at, :updated_at
json.url article_url(article, format: :json)
