json.data do
  json.categories @categories do |category|
    json.id category.id
    json.name category.name
    json.mainType category.main_type
    json.icon category.icon
  end
end
