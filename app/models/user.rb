class User < ActiveRecord::Base

  # Connects this user object to Hydra behaviors.
  include Hydra::User
  # Connects this user object to Hyrax behaviors.
  include Hyrax::User
  include Hyrax::UserUsageStats

  # Connects this user object to Role-management behaviors. 
  include Hydra::RoleManagement::UserRoles
  include AgraKms::UserRoles

    if Blacklight::Utils.needs_attr_accessible?
      attr_accessible :email, :password, :password_confirmation
    end
    
    attr_accessor :validate_pwd

#  attr_accessible :email, :password, :password_confirmation if Rails::VERSION::MAJOR < 4
# Connects this user object to Blacklights Bookmarks.
  include Blacklight::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  groupify :group_member
  groupify :named_group_member
  
  validates_presence_of :password, :password_confirmation, on: :create
  validates_confirmation_of :password, on: :create
  validates_presence_of :password, :password_confirmation, on: :update, if: :validate_pwd
  validates_confirmation_of :password, on: :update, if: :validate_pwd
#  validate :pwd_update_presence
  
  # Method added by Blacklight; Blacklight uses #to_s on your
  # user class to get a user-displayable login/identifier for
  # the account.
  def to_s
    email
  end

  def groups
    group_memberships = []

    GroupMembership.where(member_id: id).find_each do |gm|
      group_memberships << gm.group_name
    end

    @groups = group_memberships
  end
  
  def new_account_notification
    token = set_reset_password_token
    send_devise_notification(:send_account_notification, token, {})
  end
  
#  def valid_password?(password)
    # Not using passwords for standard users so always return true
#    true
#  end
end