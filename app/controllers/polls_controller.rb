class PollsController < ApplicationController

  def index
    @polls = Poll.all.includes(:options)
  end
end
