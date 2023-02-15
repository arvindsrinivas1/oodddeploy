json.extract! purchase, :id, :credit_card, :phone_number, :address, :total_price, :created_at, :updated_at
json.url purchase_url(purchase, format: :json)
