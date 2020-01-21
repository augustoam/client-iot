class HomeController < ApplicationController
  require 'rubygems'

  def index
    if admin_signed_in?
      redirect_to admin_home_admin_index_path
    else redirect_to root_index_path
    end
  end
end
