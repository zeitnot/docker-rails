require 'rails_helper'

RSpec.describe PollsController, type: :controller do

  describe '#index' do

    before do
      @polls = FactoryBot.create_list(:poll, 3)
    end

    it 'returns 200 status code' do
      get(:index)
      expect(response).to be_ok
    end

    it 'returns 3 polls' do
      get(:index)

      polls = assigns(:polls)
      expect(polls.count).to be(3)

      expect(polls.order(:id)).to eq(@polls.sort_by(&:id))
    end
  end

  describe '#vote' do

    before do
      @poll = FactoryBot.create(:poll_with_options)
    end

    context 'when user voted before' do

      before do
        @option = @poll.options.first
        @poll.vote_for(@option, request.remote_ip)
        expect(Vote.where(poll: @poll)).to be_one
      end

      it 'returns 422 status code' do
        post(:vote, params: { id: @poll, option_id: @option.id })

        expect(response).to have_http_status(422)
        expect(Vote.where(poll: @poll)).to be_one
      end
    end

    context 'when user did NOT voted before' do
      it 'returns 201 status code' do
        option = @poll.options.first
        expect(Vote).to be_none

        post(:vote, params: { id: @poll, option_id: option })

        expect(response).to be_created
        expect(Vote.where(poll: @poll, poll_option: option)).to be_one
      end
    end
  end
end
