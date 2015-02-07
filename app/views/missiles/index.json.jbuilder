json.array!(@missiles) do |missile|
  json.extract! missile, :id
  json.url missile_url(missile, format: :json)
end
