require 'rails_helper'

RSpec.describe PollsController, type: :controller do

  before do
    @polls = FactoryBot.create_list(:poll, 3)
  end

  describe '#index' do
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
end
