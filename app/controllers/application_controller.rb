class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  require 'csv' 
# def default_url_options(options = nil)
  #  if Rails.env.production?
 # { :host => "youp0wn.com" }
#	else
#	  { :host => "127.0.0.1:3000" }
#	end
#end
end
