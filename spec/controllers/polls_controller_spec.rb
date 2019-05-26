require 'rails_helper'

RSpec.describe PollsController, type: :controller do

  describe '#index' do
    it 'returns 200 status code' do
      get(:index)
      expect(response).to be_ok
    end
  end
end
