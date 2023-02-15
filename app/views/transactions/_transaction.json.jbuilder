json.extract! transaction, :id, :transaction_number, :credit_card_number, :address, :phone_no, :quantity, :total_price, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
