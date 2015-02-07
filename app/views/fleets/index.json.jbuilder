json.array!(@fleets) do |fleet|
  json.extract! fleet, :id
  json.url fleet_url(fleet, format: :json)
end
