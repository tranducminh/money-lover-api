json.data do
  json.teams @teams do |team|
    json.id team.id
    json.name team.name
    json.owner do
      json.id team.owner.id
      json.name team.owner.name
      json.email team.owner.email
    end
  end 
end