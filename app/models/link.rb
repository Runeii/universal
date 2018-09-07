class Link < ApplicationRecord
  belongs_to :track, optional: true
  belongs_to :album, optional: true
  belongs_to :artist, optional: true

  before_validation :set_url_with_protocol
  validates :url, uniqueness: true, presence: true, url: true
  validate :url_points_to_something

  def set_relationship (type, child)
    puts "We would be setting a #{type} with this data:"
    puts child
    self[type] = child
  end

  private
  def set_url_with_protocol
    puts self.inspect
    self.url_with_protocol = self.url
    self.url.gsub!('http:', 'https:')
    self.url.gsub!(':/', '://')
    puts 'Tidied'
    puts self.inspect
  end

  def url_points_to_something
    return false if self.errors.size > 0 # We've alredy failed URL validation at this point
    spotify = Spotify.new
    points_to = spotify.parse_url(self.url)
    set_relationship(points_to[0], points_to[1])
    return true if points_to
  end


end
