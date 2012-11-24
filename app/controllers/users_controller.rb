class UsersController < ApplicationController
  
  before_filter :authenticate_user!

  def me
    respond_to do |format|
      format.html
      format.json { render: current_user }
    end
  end
end
