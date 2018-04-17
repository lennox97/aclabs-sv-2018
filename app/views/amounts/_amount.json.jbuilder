json.extract! amount, :id, :user_id, :currency_id, :quantity, :created_at, :updated_at
json.url amount_url(amount, format: :json)
