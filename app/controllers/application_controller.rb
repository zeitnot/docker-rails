class ApplicationController < ActionController::Base

  def hello
    render plain: 'Hellow World'
  end
end
