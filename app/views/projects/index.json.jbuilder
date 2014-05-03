json.array!(@projects) do |project|
  json.extract! project, :id, :name, :kickoff, :rolloff, :status, :location, :type, :initiative
  json.url project_url(project, format: :json)
end
