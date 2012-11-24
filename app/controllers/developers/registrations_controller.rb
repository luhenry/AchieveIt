class RegistrationsController < Devise::RegistrationsController
  
  protected

  def after_sign_up_path_for resource
    '/admin/sign_up/success'
  end

  def after_sign_in_path_for resource
    '/admin'
  end
end