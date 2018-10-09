module GenerateRelations
  extend ActiveSupport::Concern
  
  def find_or_create_artist (name, data = false)
    existing = Artist.find_by_name(name)
    return existing if existing

    artist = Artist.new
    if data
      artist.update_attributes({
        name: name
      })
    else
      artist.update_attributes({
        name: name
      })
    end
    if artist.save
      return artist
    else
      raise Exception.new("Failed to create new artist #{name}")
    end
  end

  def find_or_create_album (title, artist_name, data = false)
    artist = Artist.find_by_name(artist_name)

    existing = artist.albums.where(title: title)
    return existing[0] unless existing.empty?

    album = Album.new
    if data
      album.update_attributes({
        title: title
        # release_date: data.release_date
      })
    else
      album.update_attributes({
        title: title
      })
    end
    if artist.save
      artist.albums << album
      return album
    else
      raise Exception.new("Failed to create new album #{title}}")
    end
  end
end