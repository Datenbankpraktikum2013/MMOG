json.array!(@ranks) do |rank|
  json.extract! rank, :name, :can_kick, :can_massmail, :can_edit, :can_invite, :can_disband
  json.url rank_url(rank, format: :json)
end
