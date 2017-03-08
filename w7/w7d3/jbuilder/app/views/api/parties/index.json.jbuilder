json.array! @parties do |party|
  json.partial! 'api/parties/party', party: party, display_gift: false
end
