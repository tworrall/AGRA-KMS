case Rails.env
when 'development', 'integration'
  # NOTE: Not deleting users so dev team members who have changed their password do not have it changed out from under them.
  # User.delete_all if User.count

  puts ('Adding Training users...')
  # fetch the depositor role 
  depositor_role =  Role.find_or_create_by(name: 'depositor')

  # create the training users. find_or_create_by does not support batch opertaions
  # password_confirmation are devise methods and not actual db columns
  
  user1 = User.find_or_create_by(email: "user_one@agra.org") do |user1|
    user1.display_name = "User One"
    user1.password = "user_1"
    user1.password_confirmation = "user_1"
  end
  user1.roles << depositor_role unless user1.roles.include?(depositor_role)
  user1.save!

  user2 = User.find_or_create_by(email: "user_two@agra.org") do |user2|
    user2.display_name = "User Two"
    user2.password = "user_2"
    user2.password_confirmation = "user_2"
  end
  user2.roles << depositor_role unless user2.roles.include?(depositor_role)
  user2.save!

  user3 = User.find_or_create_by(email: "user_three@agra.org") do |user3|
    user3.display_name = "User Three"
    user3.password = "user_3"
    user3.password_confirmation = "user_3"
  end
  user3.roles << depositor_role unless user3.roles.include?(depositor_role)
  user3.save!

  user4 = User.find_or_create_by(email: "user_four@agra.org") do |user4|
    user4.display_name = "User Four"
    user4.password = "user_4"
    user4.password_confirmation = "user_4"
  end
  user4.roles << depositor_role unless user4.roles.include?(depositor_role)
  user4.save!

  user5 = User.find_or_create_by(email: "user_five@agra.org") do |user5|
    user5.display_name = "User Five"
    user5.password = "user_5"
    user5.password_confirmation = "user_5"
  end
  user5.roles << depositor_role unless user5.roles.include?(depositor_role)
  user5.save!

  user6 = User.find_or_create_by(email: "user_six@agra.org") do |user6|
    user6.display_name = "User Six"
    user6.password = "user_6"
    user6.password_confirmation = "user_6"
  end
  user6.roles << depositor_role unless user6.roles.include?(depositor_role)
  user6.save!

  user7 = User.find_or_create_by(email: "user_seven@agra.org") do |user7|
    user7.display_name = "User Seven"
    user7.password = "user_7"
    user7.password_confirmation = "user_7"
  end
  user7.roles << depositor_role unless user7.roles.include?(depositor_role)
  user7.save!

  user8 = User.find_or_create_by(email: "user_eight@agra.org") do |user8|
    user8.display_name = "User Eight"
    user8.password = "user_8"
    user8.password_confirmation = "user_8"
  end
  user8.roles << depositor_role unless user8.roles.include?(depositor_role)
  user8.save!

  user9 = User.find_or_create_by(email: "user_nine@agra.org") do |user9|
    user9.display_name = "User nine"
    user9.password = "user_9"
    user9.password_confirmation = "user_9"
  end
  user9.roles << depositor_role unless user9.roles.include?(depositor_role)
  user9.save!

  user10 = User.find_or_create_by(email: "user_ten@agra.org") do |user10|
    user10.display_name = "User Ten"
    user10.password = "user_10"
    user10.password_confirmation = "user_10"
  end
  user10.roles << depositor_role unless user10.roles.include?(depositor_role)
  user10.save!

  user11 = User.find_or_create_by(email: "user_eleven@agra.org") do |user11|
    user11.display_name = "User Eleven"
    user11.password = "user_11"
    user11.password_confirmation = "user_11"
  end
  user11.roles << depositor_role unless user11.roles.include?(depositor_role)
  user11.save!

  user12 = User.find_or_create_by(email: "user_twelve@agra.org") do |user12|
    user12.display_name = "User Twelve"
    user12.password = "user_12"
    user12.password_confirmation = "user_12"
  end
  user12.roles << depositor_role unless user12.roles.include?(depositor_role)
  user12.save!

  user13 = User.find_or_create_by(email: "user_thirteen@agra.org") do |user13|
    user13.display_name = "User Thirteen"
    user13.password = "user_13"
    user13.password_confirmation = "user_13"
  end
  user13.roles << depositor_role unless user13.roles.include?(depositor_role)
  user13.save!

  user14 = User.find_or_create_by(email: "user_fourteen@agra.org") do |user14|
    user14.display_name = "User Fourteen"
    user14.password = "user_14"
    user14.password_confirmation = "user_14"
  end
  user14.roles << depositor_role unless user14.roles.include?(depositor_role)
  user14.save!

  user15 = User.find_or_create_by(email: "user_fifteen@agra.org") do |user15|
    user15.display_name = "User Fifteen"
    user15.password = "user_15"
    user15.password_confirmation = "user_15"
  end
  user15.roles << depositor_role unless user15.roles.include?(depositor_role)
  user15.save!

  puts ("Done.")
end