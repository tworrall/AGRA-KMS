class AgraKms::AgraKmsMailer < Devise::Mailer   
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  def send_account_notification(record, token, opts={})
    @token = token
    devise_mail(record, :send_account_notification, opts)
  end
  
end