json.extract! cart_detail, :id, :quantity, :created_at, :updated_at
json.url cart_detail_url(cart_detail, format: :json)
