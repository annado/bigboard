json.array!(@people) do |person|
  json.extract! person, :id, :uid, :name, :image, :team_id, :project_id, :role_id
  json.url person_url(person, format: :json)
end
