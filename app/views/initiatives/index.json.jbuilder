json.array!(@initiatives) do |initiative|
  json.extract! initiative, :id, :name, :start_date, :end_date, :manager_id, :analyst_id, :owner_id
  json.url initiative_url(initiative, format: :json)
end
