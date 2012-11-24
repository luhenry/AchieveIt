class RegistrationsController < Devise::RegistrationsController
  
  protected

  def after_sign_up_path_for resource
    '//dev.gameup.co/sign_up/success'
  end
end