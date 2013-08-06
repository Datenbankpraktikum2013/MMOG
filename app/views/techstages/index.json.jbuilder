json.array!(@techstages) do |techstage|
  json.extract! techstage, :spyreport_id, :technology_id, :level
  json.url techstage_url(techstage, format: :json)
end
