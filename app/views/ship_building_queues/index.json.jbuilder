json.array!(@ship_building_queues) do |ship_building_queue|
  json.extract! ship_building_queue, :planet_id, :end_time, :ship_id
  json.url ship_building_queue_url(ship_building_queue, format: :json)
end
