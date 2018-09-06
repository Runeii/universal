class Spotify
  require 'rspotify'
  def initialize
    RSpotify.authenticate(ENV['SPOTIFY_CLIENT'], ENV['SPOTIFY_SECRET'])
  end

  def parse_link url
    url.remove!('https://').remove!('http://').remove!('open.spotify.com/')
    components = url.split('/')
    return components unless components[0] === 'user'
    return [components[2], components[3], components[1]]
  end

  def find_by_id (id, type)
    return false unless ['track', 'artist', 'album', 'playlist', 'user'].include? type
    return "RSpotify::#{type.upcase_first}".constantize.find(id)
  end
end