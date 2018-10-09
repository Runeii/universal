class Link < ApplicationRecord
  require 'uri'

  belongs_to :track, optional: true
  belongs_to :album, optional: true
  belongs_to :artist, optional: true

  before_validation :sanitise_url
  validates :url, uniqueness: true, presence: true, url: true
  validate :url_points_to_something

  def target
    self.send(link_type)
  end

  private
  def sanitise_url
    self.url.gsub!('http:', 'https:')
    self.url.gsub!(':/', '://') if !(self.url.include? '://')
  end

  def url_points_to_something
    return false if self.errors.size > 0 # We've alredy failed URL validation at this point

    uri = URI.parse(self.url)
    return errors.add(:url, 'Unable to parse supplied URL') if !uri.host

    if (uri.host.include?('spotify') || uri.scheme.include?('spotify'))
      build_data_from_spotify
    else
      errors.add(:url, 'Not a valid service URL')
    end
  end

  def build_data_from_spotify
    spotify = Spotify.new
    points_to = spotify.parse_url(self.url)
    association = spotify.build_record(points_to[:id], points_to[:type])
    set_relationship(points_to[:type], association)
  end

  def set_relationship (type, child)
    self.link_type = type
    return self.track = child if type === 'track'
    return self.album = child if type === 'album'
    return self.artist = child if type === 'artist'
    return self.playlist = child if type === 'playlist'
  end

end
