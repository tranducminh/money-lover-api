json.data do
  json.wallet do
    json.id @wallet.id
    json.name @wallet.name
    json.total @wallet.total
    json.isFreezed @wallet.is_freezed
    json.categories @wallet.categories
    json.team @wallet.team
    json.transactions @wallet.transactions
  end
end
