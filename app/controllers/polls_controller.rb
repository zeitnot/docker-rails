class PollsController < ApplicationController
  before_action :load_poll, only: :vote

  # GET /polls
  def index
    @polls = Poll.all.includes(:options)
  end

  # POST /polls/:id/vote
  def vote
    form = VotePollForm.new(poll_parameters)
    form.save ? head(:created) : render(json: form.errors, status: :unprocessable_entity)
  end

  private

  def load_poll
    @poll = Poll.find(params[:id])
  end

  def poll_parameters
    params.slice(:option_id).merge(poll: @poll, ip: request.remote_ip)
  end
end
