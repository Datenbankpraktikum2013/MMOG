json.array!(@receiving_reports) do |receiving_report|
  json.extract! receiving_report, :report_id_id, :user_id_id, :read
  json.url receiving_report_url(receiving_report, format: :json)
end
