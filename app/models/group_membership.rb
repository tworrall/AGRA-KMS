class GroupMembership < ActiveRecord::Base
  groupify :group_membership
  validates :group_id, presence: true
  validates :member_id, presence: true
end
