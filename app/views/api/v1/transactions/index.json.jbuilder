json.data do
  json.transactions @transactions do |transaction|
    json.id transaction.id
    json.amount transaction.amount
    json.note transaction.note
    json.date transaction.date
    json.debt_exp transaction.debt_exp
    json.category do
      json.id transaction.category.id
      json.name transaction.category.name
      json.icon transaction.category.icon
      json.main_type transaction.category.main_type
    end
  end
end
