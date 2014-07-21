json.array!(@reservations) do |reservation|
  json.extract! reservation, :id, :starts_at, :user_id, :product_id, :is_canceled
  json.url reservation_url(reservation, format: :json)
end
