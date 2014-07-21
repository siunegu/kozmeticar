json.array!(@products) do |product|
  json.extract! product, :id, :name, :available_at, :is_promoted, :user_id, :description
  json.url product_url(product, format: :json)
end
