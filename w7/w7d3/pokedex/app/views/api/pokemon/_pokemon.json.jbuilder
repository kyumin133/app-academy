json.id pokemon.id
json.name pokemon.name
json.attack pokemon.attack
json.defense pokemon.defense
json.poke_type pokemon.poke_type
json.moves pokemon.moves
json.image_url asset_path(pokemon.image_url)

json.items do
  json.array! pokemon.items do |item|
    json.partial! 'api/items/item', item: item
  end
end
