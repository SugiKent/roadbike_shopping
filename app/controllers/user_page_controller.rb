class UserPageController < ApplicationController
  before_action :authenticate_user!
end
