class DevelopersController < ApplicationController

  before_filter :authenticate_developer!
end
