#
# Create Collections
#

# Create a public  collection
# @param [User] user creating the collection
# @param [String] collection type gid
# @param [String] id to use for the new collection
# @param [Hash] options holding metadata and permissions for the new collection
def create_collection(user, type_gid, id, options)
  # find existing collection if it already exists
  col = Collection.where(id: id)
  return col.first if col.present?

  # remove stale permisisons for the collection id
  remove_access(collection_id: id)

  # create collection
  col = Collection.new(id: id)
  col.attributes = options.except(:permissions)
  col.apply_depositor_metadata(user.user_key)
  col.collection_type_gid = type_gid
  col.visibility = Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC
  col.save

  # apply new permissions
  add_access(collection: col, grants: options[:permissions])
  col
end

# Add access grants to a collection
# @param collection [Collection] the collection to modify
# @param grants [Array<Hash>] array of grants to add to the collection
# @example grants
#   [ { agent_type: Hyrax::PermissionTemplateAccess::GROUP,
#       agent_id: 'my_group_name',
#       access: Hyrax::PermissionTemplateAccess::DEPOSIT } ]
# @see Hyrax::PermissionTemplateAccess for valid values for agent_type and access
def add_access(collection:, grants:)
  template = Hyrax::PermissionTemplate.find_or_create_by(source_id: collection.id)
  grants.each do |grant|
    Hyrax::PermissionTemplateAccess.find_or_create_by(permission_template_id: template.id,
                                                      agent_type: grant[:agent_type],
                                                      agent_id: grant[:agent_id],
                                                      access: grant[:access])
  end
  collection.reset_access_controls! # updates solr
end

# Remove all access grants for a specific collection id
# @param collection_id [String] the id of stale collection
def remove_access(collection_id:)
  templates = Hyrax::PermissionTemplate.where(source_id: collection_id)
  return unless templates.present?
  templates.each { |template| template.destroy! }
end

case Rails.env
when 'development', 'integration', 'staging', 'production'

  organization_gid = CollectionTypeService.organization_gid
  test_gid = CollectionTypeService.test_gid

  unless organization_gid.present?
    puts 'Failed to get Agra collection type.  Unable to create collections.'
    return
  end

  user = User.find_by(email: ENV['ADMIN_EMAIL'])
  unless user.present?
    puts 'Failed to get admin user.  Unable to create collections.'
    return
  end

  base_grants = [ { agent_type: Hyrax::PermissionTemplateAccess::GROUP, agent_id: 'admin', access: Hyrax::PermissionTemplateAccess::MANAGE } ]

  puts 'Adding Collections...'

  unless Collection.exists?(title: 'Training')
    permissions = base_grants.dup
    permissions << { agent_type: Hyrax::PermissionTemplateAccess::GROUP, agent_id: 'admin', access: Hyrax::PermissionTemplateAccess::MANAGE }
    permissions << { agent_type: Hyrax::PermissionTemplateAccess::GROUP, agent_id: 'admin', access: Hyrax::PermissionTemplateAccess::DEPOSIT }
    training = create_collection(user, test_gid, 'training',
                            title: ['Training'],
                            description: ['Training Collection'],
                            permissions: permissions)

    puts 'Created Training Collection'
  end

  unless Collection.exists?(title: 'Agra KMS')
    permissions = base_grants.dup
    permissions << { agent_type: Hyrax::PermissionTemplateAccess::GROUP, agent_id: 'admin', access: Hyrax::PermissionTemplateAccess::MANAGE }
    permissions << { agent_type: Hyrax::PermissionTemplateAccess::GROUP, agent_id: 'admin', access: Hyrax::PermissionTemplateAccess::DEPOSIT }
    agrakms = create_collection(user, organization_gid, 'agra_kms',
                            title: ['Agra KMS'],
                            description: ['Agra KMS Collection'],
                            permissions: permissions)
    puts 'Created Agra KMS Collection'
  end
  puts 'Done.'
end
