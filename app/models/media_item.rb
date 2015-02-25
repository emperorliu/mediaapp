class MediaItem < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :description, :medium, :title

  default_scope { order('created_at DESC') }

  def self.search_by_title(search_term)
    return [] if search_term.blank?
    where("title ILIKE ?", "%#{search_term}%").order("created_at DESC")
  end
end