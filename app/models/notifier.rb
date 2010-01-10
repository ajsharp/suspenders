class Notifier < ActionMailer::Base
  default_url_options[:host] = WEB_HOST
  
  # Sent when a user requests a password reset.
  # Contains the link they follow back to the site with their token
  # so they can reset the password
  def password_reset_instructions(user)
    subject       "PROJECT_NAME Password Reset Instructions"
    from          "PROJECT_NAME <noreply@example.com>"
    recipients    user.email
    sent_on       Time.now
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end
  
  # Sent when a user first signs up
  # Contains a link back to the site which verifies the email
  # and then allows the user to set their password
  def activation_instructions(user)
    subject       "Please activate your PROJECT_NAME account"
    from          "PROJECT_NAME <noreply@example.com>"
    recipients    user.email
    sent_on       Time.now
    body          :account_activation_url => register_url(user.perishable_token)
  end
  
  # Sent when a user's account activation is completed.
  def activation_confirmation(user)
    subject       "PROJECT_NAME Activation complete"
    from          "PROJECT_NAME <noreply@example.com>"
    recipients    user.email
    sent_on       Time.now
    body          :root_url => root_url
  end
  

end
