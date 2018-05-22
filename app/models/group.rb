class Group < ActiveRecord::Base
  groupify :group, members: [:users], default_members: :users
  validates :name, presence: true
  validates :name, format: { without: /\s/, message: 'cannot contain spaces' }
  validates :name, format: { with: /\A[a-zA-Z0-9]+\Z/, message: 'must be alphanumeric' }
  validates :description, presence: true
end