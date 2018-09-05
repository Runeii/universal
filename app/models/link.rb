class Link < ApplicationRecord
  belongs_to :track
  belongs_to :playlist
  belongs_to :album
  belongs_to :artist

  validates :url, uniqueness: true, presence: true, url: true
  validate :is_a_valid_url

  private
  def is_a_valid_url
  end
end
