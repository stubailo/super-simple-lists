class Note < ActiveRecord::Base
  belongs_to :list

  validates :title, presence: true
end
