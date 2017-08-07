class WelcomeController < ApplicationController
  before_action :sign_in_already
  def index
  end
end
