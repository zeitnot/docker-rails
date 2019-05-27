require 'rails_helper'

RSpec.describe 'List Polls' do
  before do
    @polls = FactoryBot.create_list(:poll, 3)
  end

  it 'list polls' do
    visit polls_path
    @polls.each do |poll|
      expect(page).to have_text(/#{poll.name}/i)
    end
  end
end