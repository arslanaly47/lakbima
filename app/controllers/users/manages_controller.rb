class Users::ManagesController < ApplicationController

  def new
    @user = User.new
  end

  def self.controller_path
    "devise/manages"
  end
end
