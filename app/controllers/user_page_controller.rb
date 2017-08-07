class UserPageController < ApplicationController
  before_action :sign_in_required
  before_action :authenticate_user!
end
