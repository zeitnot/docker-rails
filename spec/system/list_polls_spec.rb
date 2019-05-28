require 'rails_helper'

RSpec.describe 'List Polls' do

  before do
    @polls = FactoryBot.create_list(:poll_with_options, 3)
  end


  context 'poll listing' do

    before do
      visit polls_path
    end

    it 'contains poll name in h3 title' do
      @polls.each_with_index do |poll, i|
        i2 = i + 1
        node = page.find(".panel:nth-child(#{i2}) h3")
        expect(node.text).to eql(poll.name)
      end
    end

    it 'contains poll options' do
      @polls.each_with_index do |poll, i|
        i2 = i + 1
        node = page.find(".panel:nth-child(#{i2}) .poll-options")

        expect(poll.options).to be_exists
        poll.options.each do |option|
          expect(node.text).to be_match(/#{option.name}/i)
        end
      end
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