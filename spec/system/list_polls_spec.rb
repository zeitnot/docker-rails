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

  it 'toggles polls upon click', js: true do
    visit polls_path

    @polls.each_with_index do |_, i|
      i2 = i + 1
      expect(page.find(".panel:nth-child(#{i2}) .poll-options", visible: :all)).to_not be_visible

      page.evaluate_script("$('.panel:nth-child(#{i2}) .panel-heading').click()")
      expect(page.find(".panel:nth-child(#{i2}) .poll-options")).to be_visible
    end
  end
end