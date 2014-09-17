json.array!(@people) do |person|
  json.extract! person, :id, :uid, :email, :name, :image, :team_id, :location, :network_id, :permalink
  json.url board_person_url(@board, person, format: :json)
end
