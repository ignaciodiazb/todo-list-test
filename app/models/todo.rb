class Todo < ApplicationRecord
  belongs_to :user, default: -> { Current.user }

  validates :title, presence: true
end
