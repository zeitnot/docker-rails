require 'rails_helper'

RSpec.describe 'Submit for Poll' do

  before do
    @polls = FactoryBot.create_list(:poll_with_options, 3)
    visit polls_path
  end

  context 'when poll option is not selected', js: true do
    it 'shows error' do
      node = page.find("#poll-item-#{@polls.first.id}")
      node.click
      expect(node.first('span.ajax-response', visible: :all)).to_not be_visible

      node.click_button('Vote')
      expect(node.first('span.ajax-response').text).to match(/option selection is required/i)
    end
  end

  context 'when poll option is selected', js: true do
    it 'removes poll and shows poll stats' do
      node = page.find("#poll-item-#{@polls.first.id}")
      node.click
      expect(node.all('.progress')).to be_none

      node.first('input[type="radio"]').click
      node.click_button('Vote')
      expect(node.all('.progress').count).to be(1)
    end
  end
end