json.data do
  json.wallets @user_wallets do |user_wallet|
    json.id user_wallet.wallet.id
    json.name user_wallet.wallet.name
    json.total user_wallet.wallet.total
    json.is_freezed user_wallet.wallet.is_freezed
    json.role user_wallet.user_role
    json.team do 
      json.id user_wallet.wallet.team.id
      json.name user_wallet.wallet.team.name
    end
  end
end
