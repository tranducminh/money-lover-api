json.data do
  json.wallet do
    json.id @wallet.id
    json.name @wallet.name
    json.total @wallet.total
    json.is_freezed @wallet.is_freezed
    json.role User.roles[:OWNER]
    json.team do 
      json.id @wallet.team.id
      json.name @wallet.team.name
    end
  end
end
