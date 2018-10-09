class Spotify
  require 'rspotify'
  require 'uri'
  include GenerateRelations

  def initialize
    RSpotify.authenticate(ENV['SPOTIFY_CLIENT'], ENV['SPOTIFY_SECRET'])
  end

  def parse_url url
    uri = URI(url).path
    uri.slice!(0) if uri[0] === '/'
    components = uri.split('/')
    return { type: components[0], id: components[1] } unless components[0] === 'user'
    return { type: components[2], id: components[3], user: components[1] }
  end

  def find_by_id (id, type)
    return false unless ['track', 'artist', 'album', 'playlist', 'user'].include? type
    return "RSpotify::#{type.upcase_first}".constantize.find(id)
  end

  def build_record (id, type, data = false)
    data = find_by_id(id, type) unless data
    if type === 'track'
      target = Track.new
      artist = find_or_create_artist(data.artists[0].name)
      album = find_or_create_album(data.album.name, data.artists[0].name, {
        release_date: data.album.release_date
      })
      target.update_attributes({
        title: data.name,
        artist: artist,
        album: album
      })
    elsif type === 'album'
      target = Album.new
      artist = find_or_create_artist(data.artists[0].name)
      target.update_attributes({
        title: data.name,
        artist: artist
      })
    elsif type === 'artist'
      target = Artist.new
      target.update_attributes({
        name: data.name
      })
    end

    return target
  end
end