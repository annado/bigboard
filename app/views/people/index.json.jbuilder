json.array!(@people) do |person|
  json.extract! person, :id, :uid, :name, :image, :team_id, :location, :network_id
  json.url board_person_url(@board, person, format: :json)
end
