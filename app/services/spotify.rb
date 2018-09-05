class Spotify
  require 'rspotify'
  def initialize
    RSpotify.authenticate(ENV['SPOTIFY_CLIENT'], ENV['SPOTIFY_SECRET'])
  end

  def parse_link url
    url.remove!('https://').remove!('http://').remove!('open.spotify.com/').split('/')
    type = url[0]
    id = url[1]
    
    return find_by_id(id, type)
  end

  def find_by_id (id, type)
    return false unless ['track', 'artist', 'album', 'playlist', 'user'].includes type
    return "RSpotify::#{type.upcase_first}".constantize.find(id)
  end
end