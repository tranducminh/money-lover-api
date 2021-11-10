json.data do
  json.message @error_message || 'Some thing went wrong'
  json.success false
end
