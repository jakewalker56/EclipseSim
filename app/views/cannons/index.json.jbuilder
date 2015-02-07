json.array!(@cannons) do |cannon|
  json.extract! cannon, :id
  json.url cannon_url(cannon, format: :json)
end
