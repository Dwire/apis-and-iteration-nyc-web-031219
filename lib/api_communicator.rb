require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character, next_page='http://www.swapi.co/api/people/')
  #make the web request
  api_page = next_page
  all_characters = RestClient.get(api_page)
  character_hash = JSON.parse(all_characters)

  find_character(character, character_hash)
  # film_url_array(character, character_hash)
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def find_character(character, character_hash)
  select_character = character_hash["results"].select {|obj| obj.has_value?(character)}
  next_page = character_hash["next"]

  if select_character.length > 0
    movie_url_list = select_character[0]["films"]
    film_url_array(movie_url_list)
  elsif next_page.is_a? String
    get_character_movies_from_api(character, next_page)
  else
    puts "Could not find '#{character}', you sure you know your Star Wars?"
  end

end

def film_url_array(film_array)
  binding.pry
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
