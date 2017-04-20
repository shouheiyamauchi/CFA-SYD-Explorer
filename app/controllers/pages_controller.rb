class PagesController < ApplicationController
  before_filter :enable_header, :enable_navbar

  def home
  end
end
