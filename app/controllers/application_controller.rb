class ApplicationController < ActionController::Base
  def sanitise_url url
    url.gsub!('http:', 'https:')
    url.gsub!(':/', '://') if !(url.include? '://')
    return url
  end
end
