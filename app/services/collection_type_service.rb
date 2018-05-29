class CollectionTypeService
  ORGANIZATION_MACHINE_ID = 'organization'.freeze
  USER_COLLECTION_MACHINE_ID = Hyrax::CollectionType::USER_COLLECTION_MACHINE_ID

  # Return true if the collection has type Organization
  def self.organization?(collection)
    collection.collection_type_gid == organization_gid
  end
  
  # Return true if the collection has type User Collection
  def self.user_collection?(collection)
    collection.collection_type_gid == user_collection_gid
  end
  
  # Return the Organization collection type's gid
  def self.organization_gid
    gid(ORGANIZATION_MACHINE_ID)
  end
  
  # Return the User Collection collection type's gid
  def self.user_collection_gid
    gid(USER_COLLECTION_MACHINE_ID)
  end
  
  def self.gid(machine_id)
    type = Hyrax::CollectionType.find_by(machine_id: machine_id)
    return nil if type.blank?
    type.gid
  end
  private_class_method :gid
end
  
