json.data do
  json.members @user_wallets do |user_wallet|
    json.id user_wallet.user.id
    json.email user_wallet.user.email
    json.name user_wallet.user.name
    json.role user_wallet.user_role
  end
end