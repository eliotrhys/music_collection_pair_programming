require('pry-byebug')
require('pp')
require_relative('models/artist')
require_relative('models/album')


artist1 = Artist.new({
  'name' => 'Billy Blue Jeans'
  })

artist1.save


album1 = Album.new({
  'title' => 'Dont touch my denims, bro',
  'genre' => 'Denim & Bass',
  'artist_id' => artist1.id
  })

album2 = Album.new({
  'title' => 'Its in my Jeans',
  'genre' => 'Jean Metal',
  'artist_id' => artist1.id
  })

album1.save
album2.save

# album2.title = "I'm afraid you frayed my jeans"
# artist1.name = "Billy Green Garters"

# album2.update
# artist1.update
# result1 = artist1.all_albums
#
# result2 = album2.all_artists

#
#
# album2.delete
# artist1.delete



#
# pp Artist.all
# pp Album.all

pp Album.find(3)
pp Artist.find(2)


binding.pry
nil
