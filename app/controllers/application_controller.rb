class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :read_shared_sass_vars

  private

  def read_shared_sass_vars
    gon.sass_vars = SassConverter.convert()
  end
end
