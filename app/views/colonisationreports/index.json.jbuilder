json.array!(@colonisationreports) do |colonisationreport|
  json.extract! colonisationreport, :mode
  json.url colonisationreport_url(colonisationreport, format: :json)
end
