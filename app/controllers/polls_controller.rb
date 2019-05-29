class PollsController < ApplicationController
  before_action :load_poll, only: :vote
  helper_method :vote_before?

  # GET /polls
  def index
    @polls = Poll.all.includes(:options)
    @stats = Poll.stats
  end

  # POST /polls/:id/vote.json
  def vote
    @form = VotePollForm.new(poll_parameters)

    if @form.save
      respond_to do |format|
        format.json { head :created }
        format.js
      end
    else
      respond_to do |format|
        format.json { render json: @form.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def vote_before?(poll)
    Vote.where(poll: poll, ip: request.remote_ip).exists?
  end

  private

  def load_poll
    @poll = Poll.find(params[:id])
  end

  def poll_parameters
    params.slice(:option_id).merge(poll: @poll, ip: request.remote_ip)
  end
end
