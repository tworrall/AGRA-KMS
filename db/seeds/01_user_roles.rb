case Rails.env
when 'development', 'integration'
  # NOTE: Not deleting users so dev team members who have changed their password do not have it changed out from under them.
  # User.delete_all if User.count

  puts ('Adding Admin user...')
  admin_role =  Role.find_or_create_by(name: 'admin')
  depositor_role =  Role.find_or_create_by(name: 'depositor')

  # create the default admin. can't use the one-liner here because password and
  # password_confirmation are devise methods and not actual db columns
  
  admin = User.find_or_create_by(email: ENV['ADMIN_EMAIL']) do |user|
    user.password = ENV['ADMIN_PASSWORD']
    user.password_confirmation = ENV['ADMIN_PASSWORD']
  end
  admin.roles << admin_role unless admin.roles.include?(admin_role)
  admin.save!

  user = User.find_or_create_by(email: 'jaf30@cornell.edu') do |user|
    user.password = 'february02'
    user.password_confirmation = 'february02'
  end
  user.roles << admin_role unless user.roles.include?(admin_role)
  user.roles << depositor_role unless user.roles.include?(depositor_role)
  user.save!

  puts ("Done.")
end
