json.array!(@boards) do |board|
  json.extract! board, :id, :network_id, :name
  json.url board_url(board, format: :json)
end
