ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'gameup.co',
  :user_name            => 'gameup.noreply@gmail.com', # full email address (user@your.host.name.com)
  :password             => 'gameup',
  :authentication       => 'plain',
  :enable_starttls_auto => true
}