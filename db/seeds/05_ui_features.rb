case Rails.env
when 'development', 'integration'
  # NOTE: Not deleting users so dev team members who have changed their password do not have it changed out from under them.
  # User.delete_all if User.count

  puts ('Adding UI Features ...')

  # create or update the content block rows corresponding to the Features page
  
  hbc = ContentBlock.find_or_create_by(name: "header_background_color")
  hbc.value = "#ffffff"
  hbc.save

  htc = ContentBlock.find_or_create_by(name: "header_text_color")
  htc.value = "#333333"
  htc.save

  lc = ContentBlock.find_or_create_by(name: "link_color")
  lc.value = "#1caade"
  lc.save

  flc = ContentBlock.find_or_create_by(name: "footer_link_color")
  flc.value = "#bbd253"
  flc.save

  pbbc = ContentBlock.find_or_create_by(name: "primary_button_background_color")
  pbbc.value = "#e68a00"
  pbbc.save


  puts ("Done.")
end