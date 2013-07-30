json.array!(@sunsystems) do |sunsystem|
  json.extract! sunsystem, :y, :name
  json.url sunsystem_url(sunsystem, format: :json)
end
