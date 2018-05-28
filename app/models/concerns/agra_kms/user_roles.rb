module AgraKms
  module UserRoles 
    extend ActiveSupport::Concern
    included do
      has_and_belongs_to_many :roles, through: :roles 
    end

    def collection_admin?
      roles.where(name: 'collection_admin').exists?
    end

    def reviewer?
      roles.where(name: 'reviewer').exists?
    end

    def super_admin?
      roles.where(name: 'super_admin').exists?
    end

  end
end