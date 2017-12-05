json.extract! post, :id, :title, :text, :contact, :created_at, :updated_at
json.url post_url(post, format: :json)
