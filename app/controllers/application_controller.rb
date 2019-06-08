class ApplicationController < ActionController::Base

  def healthz
    head(:ok)
  end
end
